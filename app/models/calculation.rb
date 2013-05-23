class Calculation < ActiveRecord::Base
  belongs_to :session
  attr_accessible :average_bpm, :max_bpm, :min_bpm, :zone1_duration, :zone2_duration, :zone3_duration, :zone4_duration
end
