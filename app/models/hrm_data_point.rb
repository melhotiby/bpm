class HrmDataPoint < ActiveRecord::Base
  attr_accessible :bpm, :duration, :reading_end_time, :reading_start_time, :session_id
  belongs_to :session

  scope :within_zone, lambda{ |low, high| where('bpm > ? && bpm < ?', low, high) }

end
