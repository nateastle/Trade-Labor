class Schedule < ActiveRecord::Base
  attr_accessible :days, :nights, :weekends, :user_id

  belongs_to :user
end
