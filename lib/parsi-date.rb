# encoding: utf-8
#
# parsi-date.rb
#
# Author: Hassan Zamani 2012
#
# == Overview
#
# Date class represent a date in persian (jalali) calendar
#
# === Ways of calculating the date.
#
# In common usage, the date is reckoned in years since or before the Common Era
# (Hegira of Muhammad from Mecca to Medina in 622 CE), then as a month and
# day-of-the-month within the current year. This is known as the *Civil* *Date*,
# and abbreviated as +civil+ in the Date class.
#
# Instead of year, month-of-the-year, and day-of-the-month, the date can also
# be reckoned in terms of year and day-of-the-year. This is known as the *Ordinal*
# *Date*, and is abbreviated as +ordinal+ in the Date class. (Note that referring
# to this as the Julian date is incorrect.)
#
# For scientific purposes, it is convenient to refer to a date simply as a day
# count, counting from an arbitrary initial day. The date first chosen for this
# was January 1, 4713 BCE (-5335/9/1 in hijri solar calendar). A count of days from
# this date is the *Julian* *Day* *Number* or *Julian* *Date*, which is abbreviated
# as +jd+ in the Date class. This is in local time, and counts from midnight on the
# initial day. The stricter usage is in UTC, and counts from midday on the initial
# day. This is referred to in the Date class as the *Astronomical* *Julian* *Day*
# *Number*, and abbreviated as +ajd+. In the Date class, the Astronomical Julian
# Day Number includes fractional days.
#
# Another absolute day count is the *Modified* *Julian* *Day* *Number*, which
# takes November 17, 1858 (1237/08/26 in hijri solar calendar) as its initial day.
# This is abbreviated as +mjd+ in the Date class. There is also an *Astronomical*
# *Modified* *Julian* *Day* *Number*, which is in UTC and includes fractional days.
# This is abbreviated as +amjd+ in the Date class. Like the Modified Julian Day
# Number (and unlike the Astronomical Julian Day Number), it counts from midnight.
#
# === Time Zones
#
# DateTime objects support a simple representation of time zones. Time zones are
# represented as an offset from UTC, as a fraction of a day. This offset is the
# how much local time is later (or earlier) than UTC. UTC offset 0 is centred on
# England (also known as GMT). As you travel east, the offset increases until you
# reach the dateline in the middle of the Pacific Ocean; as you travel west, the
# offset decreases. This offset is abbreviated as +offset+ in the DateTime class.
#
# This simple representation of time zones does not take into account the common
# practice of Daylight Savings Time or Summer Time.
#
# Most DateTime methods return the date and the time in local time. The two
# exceptions are #ajd() and #amjd(), which return the date and time in UTC time,
# including fractional days.
#
# The Date class does not support time zone offsets, in that there is no way to
# create a Date object with a time zone. However, methods of the Date class when
# used by a DateTime instance will use the time zone offset of this instance.
#

require 'date'

module Parsi
  # Class representing a date.
  #
  # See the documentation to the file parsi-date.rb for an overview.
  #
  # Internally, the date is represented as an Astronomical Julian Day Number, +ajd+.
  # (There is also an +offset+ field for a time zone offset, but this is only for
  # the use of the DateTime subclass.)
  #
  # A new Date object is created using one of the object creation class methods
  # named after the corresponding date format, and the arguments appropriate to
  # that date format; for instance, Date::civil() (aliased to Date::new()) with
  # year, month, and day-of-month, or Date::ordinal() with year and day-of-year.
  #
  # Date objects are immutable once created.
  #
  # Once a Date has been created, date values can be retrieved for the different
  # date formats supported using instance methods. For instance, #mon() gives the
  # Civil month and #yday() gives the Ordinal day of the year. Date values can be
  # retrieved in any format, regardless of what format was used to create the
  # Date instance.
  #
  # The Date class includes the Comparable module, allowing
  # date objects to be compared and sorted, ranges of dates
  # to be created, and so forth.
  class Date

    include Comparable

    # Full month names, in Farsi. Months count from 1 to 12; a
    # month's numerical representation indexed into this array
    # gives the name of that month (hence the first element is nil).
    MONTHNAMES = [nil] + %w(فروردین اردیبهشت خرداد تیر مرداد شهریور مهر آبان آذر دی بهمن اسفند)
    # Full month names, in English. Months count from 1 to 12;
    EN_MONTHNAMES = [nil] + %w(farvardin ordibehesht khordad tir mordad shahrivar mehr aban azar day bahman esfand)

    # Full names of days of the week, in Farsi. Days of the week
    # count from 0 to 6; a day's numerical representation indexed into this array gives
    # the name of that day.
    DAYNAMES = %w(یک‌شنبه دوشنبه سه‌شنبه چهارشنبه پنج‌شنبه جمعه شنبه)

    # Full names of days of the week, in English. Days of the week
    # count from 0 to 6; a day's numerical representation indexed into this array gives
    # the name of that day.
    EN_DAYNAMES = %w(yekshanbe doshanbe seshanbe chaharshanbe panjshanbe jomee shanbe)

    # Abbreviated month names, in English.
    #
    # We don't have Farsi abbreviated month names, as they are not useful
    ABBR_MONTHNAMES = [nil] + %w(far ord kho tir mor sha meh abn azr day bah esf)

    # Abbreviated day names, in Farsi.
    ABBR_DAYNAMES = %w(۱ش ۲ش ۳ش ۴ش ۵ش ج ش)

    # Abbreviated day names, in English.
    ABBR_EN_DAYNAMES = %w(ye do se ch pj jo sh)

    [MONTHNAMES, EN_MONTHNAMES, ABBR_MONTHNAMES, DAYNAMES, EN_DAYNAMES, ABBR_DAYNAMES, ABBR_EN_DAYNAMES].each do |xs|
      xs.each{|x| x.freeze unless x.nil?}.freeze
    end

    HALF_DAYS_IN_DAY       = Rational(1, 2) # :nodoc:
    HOURS_IN_DAY           = Rational(1, 24) # :nodoc:
    MINUTES_IN_DAY         = Rational(1, 1440) # :nodoc:
    SECONDS_IN_DAY         = Rational(1, 86400) # :nodoc:
    MILLISECONDS_IN_DAY    = Rational(1, 86400*10**3) # :nodoc:
    NANOSECONDS_IN_DAY     = Rational(1, 86400*10**9) # :nodoc:
    MILLISECONDS_IN_SECOND = Rational(1, 10**3) # :nodoc:
    NANOSECONDS_IN_SECOND  = Rational(1, 10**9) # :nodoc:

    JALALI_EPOCH_IN_AJD    = Rational(3896641, 2) # :nodoc:
    MJD_EPOCH_IN_AJD       = Rational(4800001, 2) # 1858-11-17 # :nodoc:
    UNIX_EPOCH_IN_AJD      = Rational(4881175, 2) # 1970-01-01 # :nodoc:
    JALALI_EPOCH_IN_CJD    = 1948321 # :nodoc:
    MJD_EPOCH_IN_CJD       = 2400001 # :nodoc:
    UNIX_EPOCH_IN_CJD      = 2440588 # :nodoc:
    LD_EPOCH_IN_CJD        = 2299160 # :nodoc:
    DAYS_IN_MONTH          = [nil, 31, 31, 31, 31, 31, 31, 30, 30, 30, 30, 30, 29] # :nodoc:

    shared_methods = Module.new do

      # Returns true if the given year is a leap year of the calendar.
      def leap? year
        ((((((year - ((year > 0) ? 474 : 473)) % 2820) + 474) + 38) * 682) % 2816) < 682
      end
      alias_method :jalali_leap?, :leap?

      private

      DAYS_TO_FIRST_OF_MONTH = [nil, 0, 31, 62, 93, 124, 155, 186, 216, 246, 276, 306, 336] # :nodoc:

      # Convert a Civil Date to a Julian Day Number and returns the corresponding Julian Day Number.
      def civil_to_jd year, month, day # :nodoc:
        epbase = year - 474
        epyear = 474 + (epbase % 2820)

        day + DAYS_TO_FIRST_OF_MONTH[month] +
          (epyear * 682 - 110) / 2816 +
          (epyear - 1) * 365 +
          (epbase / 2820 * 1029983) +
          (JALALI_EPOCH_IN_CJD - 1)
      end

      # Convert a Julian Day Number to a Civil Date. +jday+ is the Julian Day Number.
      #
      # Returns the corresponding [year, month, day_of_month] as a three-element array.
      def jd_to_civil jday
        depoch = (jday - first_day_of_year(475))
        cycle, cyear = depoch.divmod 1029983

        if cyear == 1029982
          ycycle = 2820
        else
          aux1, aux2 = cyear.divmod 366
          ycycle = (2134 * aux1 + 2816 * aux2 + 2815) / 1028522 + aux1 + 1
        end
        year  = ycycle + 2820 * cycle + 474
        yday  = jday - first_day_of_year(year) + 1
        month = ((yday <= 186) ? yday / 31.0 : (yday - 6) / 30.0).ceil
        day   = (jday - first_day_of_month(year, month) + 1)
        [year, month, day]
      end

      # Do +year+, +month+, and day-of-month +day+ make a valid Civil Date?
      # Returns the corresponding Julian Day Number if they do, nil if they don't.
      # Invalid values cause an ArgumentError to be raised.
      def _valid_civil? year, month, day # :nodoc:
        return unless year.is_a?(Fixnum) && month.is_a?(Fixnum) && day.is_a?(Fixnum)
        return civil_to_jd(year, 12, 30) if leap?(year) && month == 12 && day == 30

        if 1 <= month && month <= 12 && 1 <= day && day <= DAYS_IN_MONTH[month]
          return civil_to_jd year, month, day
        else
          nil
        end
      end

      # Do the +year+ and day-of-year +yday+ make a valid Ordinal Date?
      # Returns the corresponding Julian Day Number if they do, or nil if they don't.
      def _valid_ordinal? year, yday
        ordinal_to_jd year, yday
      end

      def first_day_of_year year # :nodoc:
        civil_to_jd year, 1, 1
      end

      def last_day_of_year year # :nodoc:
        _valid_civil?(year, 12, 30) || civil_to_jd(year, 12, 29)
      end

      def first_day_of_month year, month # :nodoc:
        civil_to_jd year, month, 1
      end

      def last_day_of_month year, month # :nodoc:
        _valid_civil?(year, month, 31) || _valid_civil?(year, month, 30) || _valid_civil?(year, month, 29)
      end

      # Convert an Ordinal Date to a Julian Day Number.
      #
      # +year+ and +yday+ are the year and day-of-year to convert.
      #
      # Returns the corresponding Julian Day Number.
      def ordinal_to_jd year, yday # :nodoc:
        first_day_of_year(year) + yday - 1
      end

      # Convert a Julian Day Number to an Ordinal Date.
      #
      # +jday+ is the Julian Day Number to convert.
      #
      # Returns the corresponding Ordinal Date as [year, day_of_year]
      def jd_to_ordinal jday # :nodoc:
        year = jd_to_civil(jd).first
        yday = jday - first_day_of_year(year) + 1
        [year, yday]
      end

      # Convert an Astronomical Julian Day Number to a (civil) Julian Day Number.
      #
      # +ajd+ is the Astronomical Julian Day Number to convert. +offset+ is the offset from
      # UTC as a fraction of a day (defaults to 0).
      #
      # Returns the (civil) Julian Day Number as [day_number, fraction] where +fraction+ is
      # always 1/2.
      def ajd_to_jd ajd, offset=0  # :nodoc:
        (ajd + offset + HALF_DAYS_IN_DAY).divmod(1)
      end

      # Convert a (civil) Julian Day Number to an Astronomical Julian Day Number.
      #
      # +jd+ is the Julian Day Number to convert, and +fraction+ is a fraction of day.
      # +offset+ is the offset from UTC as a fraction of a day (defaults to 0).
      #
      # Returns the Astronomical Julian Day Number as a single numeric value.
      def jd_to_ajd jd, fraction, offset=0 # :nodoc:
        jd + fraction - offset - HALF_DAYS_IN_DAY
      end

      # Convert an +hour+, +minute+, +second+s period to a fractional day.
      def time_to_day_fraction hour, minute, second # :nodoc:
        Rational(hour * 3600 + minute * 60 + second, 86400)
      end

      # Convert an Astronomical Modified Julian Day Number to an Astronomical Julian Day Number.
      def amjd_to_ajd(amjd) amjd + MJD_EPOCH_IN_AJD end # :nodoc:

      # Convert an Astronomical Julian Day Number to an Astronomical Modified Julian Day Number.
      def ajd_to_amjd(ajd) ajd - MJD_EPOCH_IN_AJD end # :nodoc:

      # Convert a Modified Julian Day Number to a Julian Day Number.
      def mjd_to_jd(mjd) mjd + MJD_EPOCH_IN_CJD end # :nodoc:

      # Convert a Julian Day Number to a Modified Julian Day Number.
      def jd_to_mjd(jd) jd - MJD_EPOCH_IN_CJD end # :nodoc:

      # Convert a count of the number of days since the adoption of the Gregorian Calendar
      # (in Italy) to a Julian Day Number.
      def ld_to_jd(ld) ld + LD_EPOCH_IN_CJD end # :nodoc:

      # Convert a Julian Day Number to the number of days since the adoption of the
      # Gregorian Calendar (in Italy).
      def jd_to_ld(jd) jd - LD_EPOCH_IN_CJD end # :nodoc:

      # Convert a Julian Day Number to the day of the week.
      #
      # Sunday is day-of-week 0; Saturday is day-of-week 6.
      def jd_to_wday(jd) (jd + 1) % 7 end # :nodoc:

      # Is +jd+ a valid Julian Day Number?
      #
      # If it is, returns it. In fact, any value is treated as a valid Julian Day Number.
      def _valid_jd?(jd) jd end # :nodoc:
    end

    extend  shared_methods
    include shared_methods

    class << self

      alias_method :new!, :new

      def valid_jd? jd
        !!_valid_jd?(jd)
      end

      def valid_ordinal? year, yday
        !!_valid_ordinal?(year, yday)
      end

      def valid_civil? year, month, day
        !!_valid_civil?(year, month, day)
      end
      alias :valid_date? :valid_civil?
      alias :valid?      :valid_civil?
      alias :exist?      :valid_civil?

      # Create a new Date object from a Julian Day Number.
      #
      # +jday+ is the Julian Day Number; if not specified, it defaults to 0.
      #
      # examples:
      #   Parsi::Date.jd 2456229     # => #<Parsi::Date: 1391-08-07>
      #   Parsi::Date.jd 2456230     # => #<Parsi::Date: 1391-08-08>
      #   Parsi::Date.jd             # => #<Parsi::Date: -5335-09-01>
      #
      def jd jday=0
        jd = _valid_jd? jday
        new! jd_to_ajd(jday, 0, 0), 0
      end

      # Create a new Date object from an Ordinal Date, specified by +year+ and day-of-year +yday+.
      # +yday+ can be negative, in which it counts backwards from the end of the year.
      #
      # examples:
      #   Parsi::Date.ordinal 1390      # => #<Parsi::Date: 1390-01-01>
      #   Parsi::Date.ordinal 1391, 120 # => #<Parsi::Date: 1391-04-27>
      #   Parsi::Date.ordinal 1390, -1  # => #<Parsi::Date: 1389-12-29>
      #
      def ordinal year=0, yday=1
        raise ArgumentError, 'invalid date' unless jd = _valid_ordinal?(year, yday)
        new! jd_to_ajd(jd, 0, 0), 0
      end

      # Create a new Date object for the Civil Date specified by +year+, +month+, and
      # day-of-month +day+.
      def civil year=1, month=1, day=1
        raise ArgumentError, 'invalid date' unless jd = _valid_civil?(year, month, day)
        new! jd_to_ajd(jd, 0, 0), 0
      end
      alias_method :new, :civil

      # Parses the given representation of date and time, and creates a date object.
      #
      # If the optional second argument is true and the detected year is in the range “00” to “99”,
      # considers the year a 2-digit form and makes it full.
      #
      # For
      def parse string, comp=true
        # TODO: Add more parse options, for example parse '۴ام فروردین ۱۳۹۱'
        m   = string.match /(?<year>\d+)(\/|-| )(?<month>\d+)(\/|-| )(?<day>\d+)/
        m ||= string.match /(?<year>\d+)(?<month>\d{2})(?<day>\d{2})/
        if m.nil?
          raise ArgumentError.new 'invalid date'
        else
          year, month, day = m[:year].to_i, m[:month].to_i, m[:day].to_i
          if comp && m[:year].length == 2
            centry = Date.today.year / 100
            year = (m[:year].prepend centry.to_s).to_i
          end
          if jd = _valid_civil?(year, month, day)
            new! jd_to_ajd(jd, 0, 0), 0
          else
            raise ArgumentError.new 'invalid date'
          end
        end
      end

      # Create a new Date object representing today.
      def today
        ::Date.today.to_parsi
      end
    end

    # Create a new Date object.
    #
    # +ajd+ is the Astronomical Julian Day Number.
    # +offset+ is the offset from UTC as a fraction of a day.
    def initialize ajd=0, offset=0
      @ajd, @offset = ajd, offset
    end

    # Get the date as an Astronomical Julian Day Number.
    def ajd
      @ajd
    end

    def offset
      @offset
    end
    private :offset

    # Get the date as an Astronomical Modified Julian Day Number.
    def amjd
      @amjd ||= ajd_to_amjd ajd
    end

    # Get the date as a Julian Day Number.
    def jd
      @jd ||= ajd_to_jd(ajd, offset).first
    end

    # Get any fractional day part of the date.
    def day_fraction
      @day_fraction ||= ajd_to_jd(ajd, offset).last
    end

    # Get the date as a Modified Julian Day Number.
    def mjd
      @mjd ||= jd_to_mjd jd
    end

    # Get the date as the number of days since the Day of Calendar
    # Reform (in Italy and the Catholic countries).
    def ld
      @ld ||= jd_to_ld jd
    end

    # Get the date as a Civil Date, [year, month, day_of_month]
    def civil # :nodoc:
      @civil ||= jd_to_civil jd
    end

    # Get the date as an Ordinal Date, [year, day_of_year]
    def ordinal # :nodoc:
      @ordinal ||= jd_to_ordinal jd
    end

    private :civil, :ordinal

     # Get the year of this date.
    def year() civil[0] end

    # Get the month of this date.
    #
    # Farvardin is month 1.
    def mon() civil[1] end
    alias_method :month, :mon

    # Get the day-of-the-month of this date.
    def mday() civil[2] end
    alias_method :day,   :mday

    # Get the day-of-the-year of this date.
    #
    # January 1 is day-of-the-year 1
    def yday; ordinal[1] end

    # Get the week day of this date. Sunday is day-of-week 0;
    # Saturday is day-of-week 6.
    def wday
      @wday ||= jd_to_wday jd
    end

    ::Date::DAYNAMES.each_with_index do |n, i|
      define_method(n.downcase + '?'){ wday == i }
    end

    EN_DAYNAMES.each_with_index do |n, i|
      define_method(n.downcase + '?'){ wday == i }
    end

    # Return a new Date object that is +n+ days later than the current one.
    #
    # +n+ may be a negative value, in which case the new Date is earlier
    # than the current one; however, #-() might be more intuitive.
    #
    # If +n+ is not a Numeric, a TypeError will be thrown. In particular,
    # two Dates cannot be added to each other.
    def + n
      case n
      when Numeric
        return self.class.new!(ajd + n, offset)
      end
      raise TypeError, 'expected numeric'
    end

    # If +x+ is a Numeric value, create a new Date object that is +x+ days
    # earlier than the current one.
    #
    # If +x+ is a Date, return the number of days between the two dates; or,
    # more precisely, how many days later the current date is than +x+.
    #
    # If +x+ is neither Numeric nor a Date, a TypeError is raised.
    def - x
      case x
      when Numeric
        return self.class.new!(ajd - x, offset)
      when Date
        return ajd - x.ajd
      end
      raise TypeError, 'expected numeric or date'
    end

    # Compare this date with another date.
    #
    # +other+ can also be a Numeric value, in which case it is interpreted as an
    # Astronomical Julian Day Number.
    #
    # Comparison is by Astronomical Julian Day Number, including fractional days.
    # This means that both the time and the timezone offset are taken into account
    # when comparing two DateTime instances. When comparing a DateTime instance
    # with a Date instance, the time of the latter will be considered as falling
    # on midnight UTC.
    def <=> other
      case other
      when Numeric
        return ajd <=> other
      when Date
        return ajd <=> other.ajd
      when ::Date
        return ajd <=> other.ajd
      else
        begin
          left, right = other.coerce(self)
          return left <=> right
        rescue NoMethodError
        end
      end
      nil
    end

    # The relationship operator for Date.
    #
    # Compares dates by Julian Day Number. When comparing two DateTime instances,
    # or a DateTime with a Date, the instances will be regarded as equivalent if
    # they fall on the same date in local time.
    def === (other)
      case other
      when Numeric
        return jd == other
      when Date; return jd == other.jd
      else
        begin
          l, r = other.coerce(self)
          return l === r
        rescue NoMethodError
        end
      end
      false
    end

    def next_day(n=1) self + n end
    def prev_day(n=1) self - n end

    # Return a new Date one day after this one.
    def next() next_day end
    alias_method :succ, :next

    # Return a new Date object that is +n+ months later than the current one.
    #
    # If the day-of-the-month of the current Date is greater than the last day of
    # the target month, the day-of-the-month of the returned Date will be the last
    # day of the target month.
    def >> n
      y, m = (year * 12 + (mon - 1) + n).divmod(12)
      m, = (m + 1) .divmod(1)
      d = mday
      until jd2 = _valid_civil?(y, m, d)
        d -= 1
        raise ArgumentError, 'invalid date' unless d > 0
      end
      self + (jd2 - jd)
    end

    # Return a new Date object that is +n+ months earlier than the current one.
    #
    # If the day-of-the-month of the current Date is greater than the last day of
    # the target month, the day-of-the-month of the returned Date will be the last
    # day of the target month.
    def << (n) self >> -n end

    def next_month(n=1) self >> n end
    def prev_month(n=1) self << n end

    def next_year(n=1) self >> n * 12 end
    def prev_year(n=1) self << n * 12 end

    def to_gregorian
      ::Date.jd jd
    end
    alias :gregorian :to_gregorian

    def to_time
      gregorian.to_time
    end

    def to_date
      self
    end

    def to_datetime
      DateTime.new! jd_to_ajd(jd, 0, 0), 0
    end

    def to_parsi
      self
    end
    alias :jalali     :to_parsi
    alias :to_jalali  :to_parsi
    alias :to_persian :to_parsi

    # Formats time according to the directives in the given format string.
    # The directives begins with a percent (%) character. Any text not listed as a
    # directive will be passed through to the output string.
    #
    # The directive consists of a percent (%) character, zero or more flags,
    # optional minimum field width, optional modifier and a conversion specifier as
    # follows.
    #
    #   %<flags><width><modifier><conversion>
    #
    # +flags+ and +conversion+ are as in +Time+ exept that the +E+ flag is not egnored
    # any more, it forse useing English names
    #
    #
    def strftime format='%Y/%m/%d'
      format.
        gsub('%%', 'PERCENT_SUBSTITUTION_MARKER').
        gsub('%+', '%a %b %e %H:%M:%S %Z %Y').
        gsub('%c', '%a %-d %B %Y').
        gsub('%x', '%D').
        gsub('%D', '%y/%m/%d').
        gsub('%F', '%Y-%m-%d').
        gsub('%v', '%e-%B-%Y').
        gsub('%Y', year.to_s).
        gsub('%C', (year / 100).to_s).
        gsub('%y', (year % 100).to_s).
        gsub('%m',  '%02d' % month).
        gsub('%_m', '%2d' % month).
        gsub('%-m', month.to_s).
        gsub('%^B', '%B').
        gsub('%B', MONTHNAMES[month]).
        gsub('%E^B', '%^EB').
        gsub('%^EB', EN_MONTHNAMES[month].capitalize).
        gsub('%EB', EN_MONTHNAMES[month]).
        gsub('%h', '%b').
        gsub('%^h', '%^b').
        gsub('%b', ABBR_MONTHNAMES[month]).
        gsub('%^b', ABBR_MONTHNAMES[month].capitalize).
        gsub('%d', '%02d' % day).
        gsub('%e', '%2d' % day).
        gsub('%-d', day.to_s).
        gsub('%j', '%03d' % yday.to_s).
        gsub('%A', DAYNAMES[wday]).
        gsub('%a', ABBR_DAYNAMES[wday]).
        gsub('%EA', EN_DAYNAMES[wday]).
        gsub('%Ea', ABBR_EN_DAYNAMES[wday]).
        gsub('%E^A', '%^EA').
        gsub('%^EA', EN_DAYNAMES[wday].capitalize).
        gsub('%E^a', '%^Ea').
        gsub('%^Ea', ABBR_EN_DAYNAMES[wday].capitalize).
        gsub('%w', wday.to_s).
        gsub('%n', "\n").
        gsub('%t', "\t").
        gsub('PERCENT_SUBSTITUTION_MARKER', '%')
    end


    # Step the current date forward +step+ days at a time (or backward, if +step+ is
    # negative) until we reach +limit+ (inclusive), yielding the resultant date at each step.
    def step limit, step=1
      return to_enum(:step, limit, step) unless block_given?

      date = self
      comp_op = %w(== <= >=)[step <=> 0]
      while date.send comp_op, limit
        yield date
        date += step
      end
      self
    end

    # Step forward one day at a time until we reach +max+
    # (inclusive), yielding each date as we go.
    def upto max, &block # :yield: date
      step max, 1, &block
    end

    # Step backward one day at a time until we reach +min+
    # (inclusive), yielding each date as we go.
    def downto min, &block # :yield: date
      step min, -1, &block
    end

    # Is this Date equal to +other+?
    #
    # +other+ must both be a Date object, and represent the same date.
    def eql? (other) self.class === other && self == other end

    # Calculate a hash value for this date.
    def hash() ajd.hash end

    # Return internal object state as a programmer-readable string.
    def inspect
      format('#<%s: %s (%s,%s)>', self.class, to_s, ajd, offset)
    end

    # Return the date as a human-readable string.
    #
    # The format used is YYYY-MM-DD.
    def to_s() format('%.4d-%02d-%02d', year, mon, mday) end

    # Dump to Marshal format.
    def marshal_dump() [@ajd, @offset] end

    # Load from Marshal format.
    def marshal_load(a) @ajd, @of, = a end
  end
end

class Date
  class << self
    # Creates a Date object corresponding to the specified Jalali Date +year+, +month+ and
    # +day+.
    def parsi year=0, month=1, day=1
      Parsi::Date.civil year, month, day
    end
    alias :jalali :parsi
  end

  # Returns a Parsi::Date object representing same date in Jalali calendar
  def to_parsi
    Parsi::Date.new! ajd, offset
  end
  alias :jalali     :to_parsi
  alias :to_jalali  :to_parsi
  alias :to_persian :to_parsi
end

require 'parsi-datetime'
