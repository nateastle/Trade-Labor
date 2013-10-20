class User < ActiveRecord::Base
  rolify
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :email, :password, :password_confirmation, :remember_me, 
  :postal_code, :name, :first_name, :last_name,:business_name, :address_1, :address_2, :city, :state, :contact_phone, :cell_phone, :skill_ids,:terms_of_service ,:schedule_attributes,:skill_tokens,:membership,:ip_address

  attr_accessor :membership , :ip_address

  attr_reader :skill_tokens

  has_many :photos, :dependent => :destroy 
  has_one :schedule, :dependent => :destroy
  has_and_belongs_to_many :skills
  has_one :payment_detail 

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


  after_save :reindex_user!
  before_save :set_name

  RADIUS = 25 

  # TODO : We can calculcate lat , long at the time of registration so we will
  #not need a saprate zipcoe model and an "additional query".
  
  def set_name
       self.name = "#{first_name} #{last_name}".strip
  end  


  def valid_postal_code
     errors.add(:postal_code, "Postal code is invalid")  unless  zipcode
  end

  def zipcode
       ZipCode.find_by_ZipCode(postal_code)
  end
  ######## Searchable block ########
  searchable do
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
       User.search do
        fulltext query
        with(:location).in_radius(current_user.zipcode.Latitude.to_f, current_user.zipcode.Longitude.to_f, RADIUS)
        paginate :page => 1, :per_page => 25
       end.results
    else
       User.search do
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
              add_role Role::ROLES[membership.to_sym][:name].to_sym 
              return true if save!
            end  
        elsif membership.to_s == Role::ROLES[:basic][:name]
            add_role Role::ROLES[membership.to_sym][:name].to_sym
            return true if save!
        end
        
        return false 
  end 

  private

  # def validate_card_for_payment_detail
  #      payment_detail.validate_card if payment_detail 
  # end 

end
