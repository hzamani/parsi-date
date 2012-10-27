# encoding: utf-8

require 'date'

module Parsi
  MONTHNAMES = [nil] + %w(فروردین اردیبهشت خرداد تیر مرداد شهریور مهر آبان آذر دی بهمن اسفند)
  ABBR_MONTHNAMES = [nil] + %w(Far Ord Kho Tir Mor Sha Meh Abn Azr Dey Bah Esf)
  DAYNAMES = %w(شنده یک‌شنده دوشنده سه‌شنده چهارشنده چنج‌شنده جمعه)
  ABBR_DAYNAMES = %w(ش ۱ش ۲ش ۳ش ۴ش ۵ش ج)
  [MONTHNAMES, ABBR_MONTHNAMES, DAYNAMES, ABBR_DAYNAMES].each &:freeze

  class Date
    include Comparable

    attr_reader :year, :month, :day

    DAYS_TO_FIRST_OF_MONTH = [nil, 0, 31, 62, 93, 124, 155, 186, 216, 246, 276, 306, 336]
    DAYS_IN_MONTH = [nil, 31, 31, 31, 31, 31, 31, 30, 30, 30, 30, 30, 29]
    PERSIAN_EPOCH = 1948320.5

    class << self

      def leap? year
        ((((((year - ((year > 0) ? 474 : 473)) % 2820) + 474) + 38) * 682) % 2816) < 682
      end
      alias :exist? :leap?

      def valid? year, month, day
        return false unless year.is_a?(Fixnum) && month.is_a?(Fixnum) && day.is_a?(Fixnum)
        return true if leap?(year) && month == 12 && day == 30

        1 <= month && month <= 12 && 1 <= day && day <= DAYS_IN_MONTH[month]
      end

      def jd jday=0
        jday = jday.floor

        depoch = (jday - Date.new(475, 1, 1).jd).floor
        cycle = depoch / 1029983
        cyear = depoch % 1029983

        if cyear == 1029982
            ycycle = 2820
        else
            aux1 = cyear / 366
            aux2 = cyear % 366
            ycycle = (2134 * aux1 + 2816 * aux2 + 2815) / 1028522 + aux1 + 1
        end
        year = ycycle + 2820 * cycle + 474
        year -= 1 if year <= 0

        yday = jday - Date.new(year, 1, 1).jd + 1
        month = (yday <= 186) ? (yday / 31.0).ceil : ((yday - 6) / 30.0).ceil
        day = (jday - Date.new(year, month, 1).jd + 1).floor
        Date.new year, month, day
      end

      alias :civil :new

      def ordinal year, ydays=1
        jd = Date.new(year, 1, 1).jd + ydays - 1
        Date.jd jd
      end


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
          if Date.valid? year, month, day
            Date.new year, month, day
          else
            raise ArgumentError.new 'invalid date'
          end
        end
      end

      def today
        Date.jd ::Date.today.jd
      end

      def tomorrow ; today + 1 end
      def yesterday; today - 1 end
    end

    def initialize year=0, month=1, day=1
      raise ArgumentError.new 'invalid date' unless
        Date.valid? year, month, day

      @year, @month, @day = year, month, day
    end

    alias :mon :month
    alias :mday :day

    def to_s sep='/'
      "%d%s%02d%s%02d" % [year, sep, month, sep, day]
    end

    def inspect
      "#<Parsi::Date: #{to_s}>"
    end

    def jd
      @jd ||= begin
        epbase = year - ((year >= 0) ? 474 : 473)
        epyear = 474 + epbase % 2820

        day + DAYS_TO_FIRST_OF_MONTH[month] +
          (epyear * 682 - 110) / 2816 +
          (epyear - 1) * 365 +
          (epbase / 2820 * 1029983) +
          (PERSIAN_EPOCH - 1) + 0.5
      end
    end

    def mjd  ; (jd - 2400001).floor end
    def ld   ; (jd - 2299160).floor end
    def ajd  ; gregorian.ajd        end
    def amjd ; gregorian.amjd       end

    def wday
      (gregorian.wday + 1) % 7
    end

    def cwday
      wday + 1
    end

    def yday
      (jd - first_of_year.jd + 1).to_i
    end

    def leap?
      Date.leap? year
    end

    def to_gregorian
      @greqorian ||= ::Date.jd jd
    end
    alias :gregorian :to_gregorian

    def strftime format='%Y/%m/%d'
      format.
        gsub('%+', '%a %b %e %H:%M:%S %Z %Y').
        gsub('%c', '%a %-d %B %Y').
        gsub('%x', '%D').
        gsub('%D', '%y/%m/%d').
        gsub('%F', '%Y-%m-%d').
        gsub('%v', '%e-%b-%Y').
        gsub('%Y', year.to_s).
        gsub('%C', (year / 100).to_s).
        gsub('%y', (year % 100).to_s).
        gsub('%m',  '%02d' % month).
        gsub('%_m', '% 2d' % month).
        gsub('%-m', month.to_s).
        gsub('%^B', '%B').
        gsub('%B', Parsi::MONTHNAMES[month]).
        gsub('%h', '%b').
        gsub('%b', Parsi::ABBR_MONTHNAMES[month]).
        gsub('%^b', Parsi::ABBR_MONTHNAMES[month].capitalize).
        gsub('%d', '%02d' % day).
        gsub('%e', '% 2d' % day).
        gsub('%-d', day.to_s).
        gsub('%j', '%03d' % yday.to_s).
        gsub('%A', Parsi::DAYNAMES[wday]).
        gsub('%a', Parsi::ABBR_DAYNAMES[wday]).
        gsub('%u', cwday.to_s).
        gsub('%w', wday.to_s).
        gsub('%n', "\n").
        gsub('%t', "\t").
        gsub('%%', '%')
    end

    def + days
      Date.jd jd + days
    end

    def - days
      Date.jd jd - days
    end

    def >> monthes
      monthes = year * 12 + month + monthes
      y = monthes / 12
      m = monthes % 12
      y -= 1 and m = 12 if m == 0
      d = day
      d -= 1 until Date.valid? y, m, d
      Date.new y, m, d
    end

    def << monthes
      self >> -monthes
    end

    def <=> other
      if other.respond_to? :jd
        jd <=> other.jd
      elsif other.is_a? Numeric
        jd <=> other
      else
        raise ArgumentError.new "comparison of #{self.class} with #{other.class} failed"
      end
    end

    def step limit, by=1
      date = self
      comp_op = %w(== <= >=)[by <=> 0]
      while date.send comp_op, limit
        yield date
        date += by
      end
      self
    end

    def upto max, &block
      step max, 1, &block
    end

    def downto min, &block
      step min, -1, &block
    end

    def next
      self + 1
    end
    alias :succ :next

    def next_day n=1
      self + n
    end

    def next_month n=1
      self >> n
    end

    def next_year n=1
      self >> (n * 12)
    end

    def prev_day n=1
      self - n
    end

    def prev_month n=1
      self << n
    end

    def prev_year n=1
      self << (n * 12)
    end

    def shanbe?       ; wday == 0 end
    def yekshanbe?    ; wday == 1 end
    def doshanbe?     ; wday == 2 end
    def seshanbe?     ; wday == 3 end
    def chaharshanbe? ; wday == 4 end
    def panjshanbe?   ; wday == 5 end
    def jomee?        ; wday == 6 end

  private
    def first_of_year
      @first_of_year ||= Date.new year, 1, 1
    end
  end
end

class Date
  def to_parsi
    Parsi::Date.jd jd
  end
  alias :parsi      :to_parsi
  alias :to_persian :to_parsi
  alias :to_jalali  :to_parsi
  alias :jalali     :to_parsi
end
