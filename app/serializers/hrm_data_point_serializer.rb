class HrmDataPointSerializer < ActiveModel::Serializer
  attributes :id, :bpm

  def attributes
    hash = super
    hash["reading_start_time"] = object.reading_start_time.strftime("%Y-%m-%d %H:%M")
    hash
  end
end
