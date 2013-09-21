class Availability < ActiveRecord::Base
  attr_accessible :days, :nights, :weekends

  belongs_to :users
end
