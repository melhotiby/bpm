module ApplicationHelper

  def convert_seconds_to_time(seconds)
    total_minutes = seconds / 1.minutes
    seconds_in_last_minute = seconds - total_minutes.minutes.seconds
    if total_minutes.zero?
      "#{seconds_in_last_minute}s"
    else
      "#{total_minutes}m #{seconds_in_last_minute}s"
    end
  end

  def json_for(target, options = {})
    options[:scope] ||= self
    options[:url_options] ||= url_options
    target.active_model_serializer.new(target, options).to_json
  end

  def overall_minimum
    Calculation.maximum(:max_bpm)
  end

  def overall_maximum
    Calculation.minimum(:min_bpm)
  end

  def overall_average
    Calculation.average(:average_bpm).to_i
  end

  def overall_percentages
    zone1 = Calculation.sum(:zone1_duration)
    zone2 = Calculation.sum(:zone2_duration)
    zone3 = Calculation.sum(:zone3_duration)
    zone4 = Calculation.sum(:zone4_duration)
    total_count = zone1 + zone2 + zone3 + zone4
    content_tag :p do
      content_tag(:p, "Zone1 Overall Percentage " + number_to_percentage((zone1.to_f/total_count * 100), :precision => 0)) + 
      content_tag(:p, "Zone2 Overall Percentage " + number_to_percentage((zone2.to_f/total_count * 100), :precision => 0)) + 
      content_tag(:p, "Zone3 Overall Percentage " + number_to_percentage((zone3.to_f/total_count * 100), :precision => 0)) + 
      content_tag(:p, "Zone4 Overall Percentage " + number_to_percentage((zone4.to_f/total_count * 100), :precision => 0))
    end
  end

end
