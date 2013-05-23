class User < ActiveRecord::Base
  attr_accessible :age, :gender, :hr_zone1_max, :hr_zone1_min, :hr_zone2_max, :hr_zone2_min, :hr_zone3_max, :hr_zone3_min, :hr_zone4_max, :hr_zone4_min, :username
  has_many :sessions
end
