module Parsi
  class DateTime < Date
    include Comparable

    attr_reader :hour, :minute, :second, :offset

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

      def jd jd=0
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

      super year, month, day
      @hour, @minute, @second, @offset = hour, minute, second, offset
    end

    def zone sep=':'
      f = offset * 24.0
      "%s%02d%s%02d" % [(f >= 0 ? '+' : '-'), f.floor, sep, (f % 1) * 60]
    end

    def to_s sep='/'
      "%sT%02d:%02d:%02d%s" % [super(sep), hour, minute, second, zone]
    end

    def inspect
      "#<#{self.class}: #{to_s('-')}>"
    end

    def strftime format='%Y/%m/%d %H:%M:%S'
      gregorian.strftime super format
    end

    def to_date
      Date.new year, month, day
    end

    def to_gregorian
     @gregorian ||= begin
       ::DateTime.new super.year, super.month, super.day, hour, minute, second, zone
     end
    end
    alias :gregorian :to_gregorian

    def + days
      date = super
      DateTime.new date.year, date.month, date.day, hour, minute, second, offset
    end

    def >> monthes
      date = super
      DateTime.new date.year, date.month, date.day, hour, minute, second, offset
    end

    def <=> other
      if other.is_a? Date
        to_gregorian <=> other.to_gregorian
      elsif other.is_a? ::Date
        to_gregorian <=> other
      else
        raise ArgumentError.new "comparison of #{self.class} with #{other.class} failed"
      end
    end
  end
end

class DateTime
  def to_parsi
    date = super
    Parsi::DateTime.new date.year, date.month, date.day, hour, minute, second, offset
  end
  alias :to_persian :to_parsi
  alias :to_jalali  :to_parsi
  alias :parsi      :to_parsi
  alias :jalali     :to_parsi
end
