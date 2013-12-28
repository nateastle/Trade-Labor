class User < ActiveRecord::Base

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :email, :password, :password_confirmation, :remember_me, 
  :postal_code, :name, :first_name, :last_name,:business_name, :address_1, :address_2, :city, :state, :contact_phone, :cell_phone, :skill_ids,:terms_of_service ,:schedule_attributes,:skill_tokens,:membership,:ip_address, :rating_average

  attr_accessor :membership , :ip_address

  attr_reader :skill_tokens

  has_many :photos, :dependent => :destroy 
  has_one :schedule, :dependent => :destroy
  has_and_belongs_to_many :skills
  has_one :payment_detail 
  belongs_to :role


  has_many :employee_businesses , :foreign_key => 'employee_id' , :class_name => "Business"
  has_many :employer_businesses , :foreign_key => 'employer_id', :class_name => "Business"

  has_many :employer , through: :business , :source => :user
  has_many :employee , through: :business , :source => :user


  accepts_nested_attributes_for :skills
  accepts_nested_attributes_for :schedule
  accepts_nested_attributes_for :photos

  validates_uniqueness_of :email
  validates :email, :first_name, :last_name, :address_1, :city, :state ,:postal_code, :business_name ,:presence => true
  validates_confirmation_of :password
  validates :postal_code, numericality: { only_integer: true }
  validates_acceptance_of :terms_of_service, :allow_nil => false, :message => "Please accept the terms and conditions", :on => :create
  validate :valid_postal_code
  validate :membership , :presence => true
  validates_inclusion_of :membership, in:  Role::ROLES.collect {|role| role[1][:name] } , :on => :create
  # validate :validate_card_for_payment_detail

  validate :validate_skills_on_role_basis


  after_save :reindex_user!
  before_save :set_name

  RADIUS = 25 


  ajaxful_rater

  # TODO : We can calculcate lat , long at the time of registration so we will
  #not need a saprate zipcoe model and an "additional query".
  

  def profile_photo_url(version)
      if self.photos.profile_photo.blank?  
        "#{version.to_s}_avtar.jpg"
      else  
        self.photos.profile_photo.first.name_url(version)
      end  
  end  

  def set_name
       self.name = "#{first_name} #{last_name}".strip
  end  

  def validate_skills_on_role_basis
    unless role.blank?
      if basic_user? 
          errors.add(:skill_tokens, "Basic user is not allowed to add skills")  if skills.length > 0
      elsif business_user?
          errors.add(:skill_tokens, "Business user is allowed to add only one skills")  if skills.length > 1
      end 
    end   
  end

  def valid_postal_code
     errors.add(:postal_code, "Postal code is invalid")  unless  zipcode
  end

  def zipcode
       ZipCode.find_by_ZipCode(postal_code)
  end
  ######## Searchable block ########
  searchable do
    text :first_name, :as => :first_name_textp  
    text :last_name, :as => :first_name_textp 
    text :business_name, :as => :first_name_textp 
    text :email, :as => :first_name_textp  
    text :skills do
      skills.map { |skill| skill.name }
    end
    
    text :search_skills , :as  => :user_skill do
      skills.map { |skill| skill.name }
    end

    text :postal_code , :as => :user_postal_code
      
    latlon(:location) { Sunspot::Util::Coordinates.new(zipcode.Latitude, zipcode.Longitude) }
    string  :postal_code
  end  

  def full_address
    [address_1, address_2, city, state, postal_code].select {|x| x.present?}.join(', ')
  end
 

  def self.find_users(query ,current_user)
    if current_user 
      logger.fatal "Query is: " + query
       User.search do
        fulltext query
        with(:location).in_radius(current_user.zipcode.Latitude.to_f, current_user.zipcode.Longitude.to_f, RADIUS)
        paginate :page => 1, :per_page => 25
       end.results
       logger.fatal "Logger count: " +  this.count.to_s
    else
       User.search do
        logger.fatal "Query is: " + query
        fulltext query
        paginate :page => 1, :per_page => 25
       end.results

    end 
  end
  
  # Reindex specific user only , instead of whole class.
  def reindex_user!
      Sunspot.index! self
  end

  def skill_tokens=(ids)
    self.skill_ids = ids.split(",")
  end

  # def save_with_payment(payment_detail) 
       
  #   if valid? 
  #     if membership == Role::ROLES[:business][:name] || membership == Role::ROLES[:premium][:name]
  #       if valid_card?(payment_detail) && payment_success?(payment_detail,Role::ROLES[membership.to_sym][:price]) 
  #          add_role Role::ROLES[membership.to_sym][:name].to_sym 
  #          save!
  #       end 
  #     else  
  #          add_role Role::ROLES[:basic][:name].to_sym
  #          save!
  #     end  
  #   end

  #   rescue exception => e
  #     logger.error "Paypal error while creating customer: #{e.message}"
  #     errors.add :base, "There was a problem with your credit card."
  #     false
  # end 

  def save_with_payment

        if membership.to_s == Role::ROLES[:business][:name]  ||  membership.to_s == Role::ROLES[:premium][:name]           
            if payment_detail.payment_success?(Role::ROLES[membership.to_sym][:price]) 
              add_role Role::ROLES[membership.to_sym][:name] 
              return true if save!
            end  
        elsif membership.to_s == Role::ROLES[:basic][:name]
            add_role Role::ROLES[membership.to_sym][:name]
            return true if save!
        end
        
        return false 
  end 

  def role?(name)
      role.name == name.to_s
  end 

  def basic_user?
      role.name == Role::ROLES[:basic][:name]
  end 

  def business_user?
      role.name == Role::ROLES[:business][:name]
  end 

  def premium_user?
      role.name == Role::ROLES[:premium][:name]
  end 

  def add_role(name)
       self.role_id = Role.find_by_name(name).id
  end  

  # def validate_card_for_payment_detail
  #      payment_detail.validate_card if payment_detail 
  # end 



  # Rating

  #TODO Remove this manual code from here , It is only for testing purpose.
  def find_or_create_business_with_current_user(user)
      business = Business.find_or_create_by_employee_id_and_employer_id(self.id,user.id)
      #business.blank? ? Business.create(:employee_id => self.id, :employer_id =>user.id , :title => 'Test Business') : business
  end  

  def already_rated?(emp)
        business_ary = Business.where("employer_id = ? and employee_id = ?",self.id,emp.id)
        business_ary.blank? ? false : (Rate.where("rater_id = ? and rateable_id = ?",self.id,business_ary.first.id).blank? ? false : true)
  end  


end
