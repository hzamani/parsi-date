module Parsi
  class DateTime
    include Comparable

    attr_reader :date, :hour, :minute, :second, :offset

    class << self
      def valid_time? hour=0, minute=0, second=0, offset=0
        if 0 <= hour   && hour   <= 23 &&
           0 <= minute && minute <= 59 &&
           0 <= second && second <= 59
          #TODO: Add offset validation
          true
        else
          false
        end
      end

      def jd jd
        date = Date.jd jd.to_i
        h = (jd - jd.to_i) * 24
        m = (h  -  h.to_i) * 60
        s = (m  -  m.to_i) * 60
        DateTime.new date.year, date.month, date.day, h.to_i, m.to_i, s.to_i
      end

      def now
        now = ::DateTime.now
        today = now.to_date.to_parsi
        DateTime.new today.year, today.month, today.day, now.hour, now.minute, now.second, now.offset
      end
    end

    def initialize year=0, month=1, day=1, hour=0, minute=0, second=0, offset=0
      raise ArgumentError.new 'invalid time' unless
        DateTime.valid_time? hour, minute, second

      @date = Parsi::Date.new year, month, day
      @hour, @minute, @second, @offset = hour, minute, second, offset
    end

    def year;  date.year  end
    def month; date.month end
    def day;   date.day   end
    def yday;  date.yday  end
    def wday;  date.wday  end
    def gwday; date.gwday end

    def zone sep=':'
      f = offset * 24.0
      "%s%02d%s%02d" % [(f >= 0 ? '+' : '-'), f.floor, sep, (f % 1) * 60]
    end

    def to_s sep='/'
      "%sT%02d:%02d:%02d%s" % [date.to_s(sep), hour, minute, second, zone]
    end

    def inspect
      "#<Parsi::Date #{to_s('-')}>"
    end

    def strftime format='%Y/%m/%d %H:%M:%S'
      gregorian.strftime date.strftime format
    end

    def to_date
      date
    end

    def to_gregorian
      @greqorian ||= begin
        g = date.to_gregorian
        ::DateTime.new g.year, g.month, g.day, hour, minute, second, zone
      end
    end
    alias :gregorian :to_gregorian

    def jd
      to_gregorian.jd
    end

    def <=> other
      to_gregorian <=> other.to_gregorian
    end
  end
end
