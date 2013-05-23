class Session < ActiveRecord::Base
  attr_accessible :duration, :user_id, :created_at
  belongs_to :user
  delegate :username, to: :user, allow_nil: true
  delegate :zone1_duration, to: :calculation, allow_nil: true
  delegate :zone2_duration, to: :calculation, allow_nil: true
  delegate :zone3_duration, to: :calculation, allow_nil: true
  delegate :zone4_duration, to: :calculation, allow_nil: true
  delegate :average_bpm, to: :calculation, allow_nil: true
  delegate :min_bpm, to: :calculation, allow_nil: true
  delegate :max_bpm, to: :calculation, allow_nil: true
  has_many :hrm_data_points, foreign_key: "session_id", dependent: :destroy
  has_one :calculation
  default_scope :order => 'created_at DESC'

  after_save :calculate

  def avg_bpm
    hrm_data_points.collect{|dp| dp.duration * dp.bpm }.sum / hrm_data_points.map(&:duration).sum
  end

  def minimum_bpm
    hrm_data_points.sort{ |a,b| a.bpm <=> b.bpm }.first.bpm
    #hrm_data_points.minimum(:bpm)
  end

  def maximum_bpm
    hrm_data_points.sort{ |a,b| b.bpm <=> a.bpm }.first.bpm
    #hrm_data_points.maximum(:bpm)
  end

  (1..4).each do |zone|
    define_method("zone#{zone}_total_duration") do
      low = user.send("hr_zone#{zone}_min")
      high = user.send("hr_zone#{zone}_max")
      hrm_data_points.within_zone(low, high).map(&:duration).sum
    end
  end

  # after_save
  def calculate
    calulation = self.build_calculation
    calulation.min_bpm = minimum_bpm
    calulation.max_bpm = maximum_bpm
    calulation.average_bpm = average_bpm
    calulation.zone1_duration = zone1_total_duration
    calulation.zone2_duration = zone2_total_duration
    calulation.zone3_duration = zone3_total_duration
    calulation.zone4_duration = zone4_total_duration
    calulation.save
  end
end
