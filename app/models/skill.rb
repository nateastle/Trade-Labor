class Skill < ActiveRecord::Base
  attr_accessible :name
  has_and_belongs_to_many :users

  after_save :reindex_users!
  

  # Reindex corresponding user only , instead of whole class.
  def reindex_users!
      Sunspot.index! self.users
  end  

end
