class Role < ActiveRecord::Base
  has_many :users

  attr_accessible :name,:id 

  ROLES = {:basic => { :name => "basic" , :price => 0.0 } ,:business => { :name => "business" , :price => 10 }  ,:premium=> { :name => "premium" , :price => 20 }  }

  def self.all_roles
  	Role::ROLES.collect {|k,v| v[:name]}
  end

  def self.import
     Role.all_roles.each { |role_name| Role.find_or_create_by_name(:name => role_name)}	
  end    	
end
