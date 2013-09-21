class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, 
  :postal_code, :name, :first_name, :last_name, :address_1, :address_2, :city, :state, :contact_phone, :cell_phone, :skill_ids
  # attr_accessible :title, :body
  has_many :photos, :dependent => :destroy 
  has_one :schedule, :dependent => :destroy
  has_and_belongs_to_many :skills
  accepts_nested_attributes_for :skills
  accepts_nested_attributes_for :schedule
  accepts_nested_attributes_for :photos

include PgSearch
pg_search_scope :search, against: [:name, :postal_code],
  using: {tsearch: {dictionary: "english"}},
  associated_against: {author: :name, skills: [:name]},
  ignoring: :accents

  def self.text_search(query)
    if query.present?
      rank = <<-RANK
        ts_rank(to_tsvector(name), plainto_tsquery(#{sanitize(query)})) +
        ts_rank(to_tsvector(postal_code), plainto_tsquery(#{sanitize(query)}))
      RANK
      where("to_tsvector('english', name) @@ :q or  to_tsvector('english', postal_code) @@:q ", q: query, y: "%#{query}%").order("#{rank} desc").limit(10)
    else
      scoped
    end
  end
end
