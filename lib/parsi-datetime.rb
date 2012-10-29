# encoding: utf-8
#
# parsi-date.rb
#
# Author: Hassan Zamani 2012

module Parsi
  # Class representing a date and time.
  #
  # See the documentation to the file parsi-date.rb for an overview.
  #
  # DateTime objects are immutable once created.
  class DateTime < Date

    shared_methods = Module.new do

      def zone_to_offset zone
        m = zone.match /(?<sign>\+|-)?(?<hour>\d{1,2}):?(?<minute>\d{,2})/
        return 0 if m.nil?
        offset = Rational(m[:hour].to_i, 24) + Rational(m[:minute].to_i, 1440)
        m[:sign] == '-' ? -offset : offset
      end
      private :zone_to_offset

      # Convert a fractional day +fraction+ to [hours, minutes, seconds, fraction_of_a_second]
      def day_fraction_to_time fraction # :nodoc:
        seconds, fraction = fraction.divmod SECONDS_IN_DAY
        hours, seconds = seconds.divmod 3600
        minutes, seconds = seconds.divmod 60
        [hours, minutes, seconds, fraction * 86400]
      end

      # Do +hour+, +minute+, and +second+ constitute a valid time?
      #
      # If they do, returns their value as a fraction of a day. If not, returns nil.
      #
      # The 24-hour clock is used. Negative values of +hour+, +minute+, and +second+ are treating
      # as counting backwards from the end of the next larger unit (e.g. a +minute+ of -2 is
      # treated as 58). No wraparound is performed.
      def _valid_time? hour, minute, second
        hour += 24 if hour < 0
        minute += 60 if minute < 0
        seconds += 60 if second < 0
        return unless ((0...24) === hour && (0...60) === minute && (0...60) === second) ||
          (24 == hour && 0 == minute && 0 == second)
        time_to_day_fraction hour, minute, second
      end
    end

    extend  shared_methods
    include shared_methods

    class << self

      def valid_time? hour, min, sec
        !!_valid_time?(hour, min, sec)
      end
      private :valid_time?

      # Create a new DateTime object corresponding to the specified Julian Day Number +jd+
      # and +hour+, +minute+, +second+.
      #
      # The 24-hour clock is used. If an invalid time portion is specified, an ArgumentError
      # is raised.
      def jd jd=0, hour=0, minute=0, second=0, zone="00:00"
        fraction = _valid_time? hour, minute, second
        raise ArgumentError, 'invalid time' if fraction.nil?

        offset = zone_to_offset zone

        new! jd_to_ajd(jd, fraction, offset), offset
      end

      # Create a new DateTime object corresponding to the specified Astronomical Julian Day
      # Number +ajd+ in given +offset+.
      def ajd ajd=0, zone="00:00"
        new! ajd, zone_to_offset(zone)
      end

      # Create a new DateTime object corresponding to the specified Ordinal Date and +hour+,
      # +minute+, +second+.
      #
      # The 24-hour clock is used. If an invalid time portion is specified, an ArgumentError
      # is raised.
      def ordinal year=0, yday=1, hour=0, minute=0, second=0, zone="00:00"
        jd = _valid_ordinal? year, yday
        fraction = _valid_time?(hour, minute, second)
        raise ArgumentError, 'invalid date' if jd.nil? or fraction.nil?

        offset = zone_to_offset zone

        new! jd_to_ajd(jd, fr, offset), offset
      end

      # Create a new DateTime object corresponding to the specified Civil Date and +hour+,
      # +minute+, +second+.
      #
      # The 24-hour clock is used. If an invalid time portion is specified, an ArgumentError is
      # raised.
      #
      # +offset+ is the offset from UTC as a fraction of a day (defaults to 0).
      def civil year=0, month=1, day=1, hour=0, minute=0, second=0, zone="00:00"
        jd = _valid_civil? year, month, day
        fraction = _valid_time? hour, minute, second
        raise ArgumentError, 'invalid date' if jd.nil? or fraction.nil?

        offset = zone_to_offset zone

        new! jd_to_ajd(jd, fraction, offset), offset
      end
      alias_method :new, :civil

      # Create a new DateTime object representing the current time.
      def now
        ::DateTime.now.to_parsi
      end

      private :today
    end

    # Get the time of this date as [hours, minutes, seconds,
    # fraction_of_a_second]
    def time # :nodoc:
      @time ||= day_fraction_to_time day_fraction
    end
    private :time

    # Get the hour of this date.
    def hour() time[0] end

    # Get the minute of this date.
    def min() time[1] end

    # Get the second of this date.
    def sec() time[2] end

    # Get the fraction-of-a-second of this date.
    def sec_fraction() time[3] end

    alias_method :minute, :min
    alias_method :second, :sec
    alias_method :second_fraction, :sec_fraction

    def to_s
      format('%.4d-%02d-%02dT%02d:%02d:%02d%s', year, mon, mday, hour, min, sec, zone)
    end

    public :offset

    def new_offset zone
      offset = zone_to_offset zone
      self.class.new! ajd, offset
    end

    def zone
      o = offset * 24
      format("%s%02d:%02d", (o >= 0 ? '+' : '-'), o.to_i, (o - o.to_i) * 60)
    end

    def strftime format='%Y/%m/%d %H:%M:%S'
      gregorian.strftime super format
    end

    def gregorian
     @gregorian ||= begin
       ::DateTime.jd jd, hour, minute, second, zone
     end
    end
    alias :to_gregorian :gregorian

    def to_time
      gregorian.to_time
    end

    def to_date
      Date.new! jd_to_ajd(jd, 0, 0), 0
    end

    def to_datetime
      self
    end
  end
end

class DateTime
  class << self
    # Creates a DateTime object corresponding to the specified Jalali Date (+year+, +month+ and
    # +day+) and time (+hour+, +minute+ and +second+) in given +zone+.
    def parsi year=0, month=1, day=1, hour=0, minute=0, second=0, zone="00:00"
      Parsi::DateTime.civil year, month, day, hour, minute, second, zone
    end
    alias :jalali :parsi
  end

  # Returns a Parsi::DateTime object representing same date in Jalali calendar
  def to_parsi
    Parsi::DateTime.new! ajd, offset
  end
  alias :jalali     :to_parsi
  alias :to_jalali  :to_parsi
  alias :to_persian :to_parsi
end

class Time
  # Returns a Parsi::DateTime object representing same date in Jalali calendar
  def to_parsi
    to_datetime.to_parsi
  end
  alias :jalali     :to_parsi
  alias :to_jalali  :to_parsi
  alias :to_persian :to_parsi
end
