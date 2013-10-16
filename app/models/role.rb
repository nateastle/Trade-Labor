class Role < ActiveRecord::Base
  has_and_belongs_to_many :users, :join_table => :users_roles
  belongs_to :resource, :polymorphic => true
  attr_accessible :name,:id 
  scopify

  ROLES = {:basic => { :name => "basic" , :price => 0.0 } ,:business => { :name => "business" , :price => 10 }  ,:premium=> { :name => "premium" , :price => 20 }  }
end
