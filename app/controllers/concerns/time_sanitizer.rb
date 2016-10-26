module TimeSanitizer
  extend ActiveSupport::Concern

  # Not used right now, we can use it for 100% certainty
  # with timezone
  def self.input(date_time)
    Time.zone.parse(date_time)
        .utc
  end

  # All output time must be in utc then converted
  # to local time
  # input MUST be a Time Object
  def self.output(time)
    time.in_time_zone
  end
end
