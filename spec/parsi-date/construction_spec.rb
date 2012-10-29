require File.expand_path('../../spec_helper', __FILE__)

describe Parsi::Date do
  context "civil" do
    it "constructs a date with arguments" do
      expect { Parsi::Date.civil 1391, 8, 6 }.to_not raise_error
      expect { Parsi::Date.civil 1391, 12, 30 }.to_not raise_error # 1391 is a leap year
    end

    it "doesn't construct dates for invalid arguments" do
      expect { Parsi::Date.civil 1391, 15,  1 }.to raise_error(ArgumentError, 'invalid date')
      expect { Parsi::Date.civil 1391,  0,  1 }.to raise_error(ArgumentError, 'invalid date')
      expect { Parsi::Date.civil 1391,  1, 32 }.to raise_error(ArgumentError, 'invalid date')
      expect { Parsi::Date.civil 1391,  2,  0 }.to raise_error(ArgumentError, 'invalid date')
      expect { Parsi::Date.civil 1391,  8, 31 }.to raise_error(ArgumentError, 'invalid date')
      expect { Parsi::Date.civil 1390, 12, 30 }.to raise_error(ArgumentError, 'invalid date') # 1390 is not a leap year
      expect { Parsi::Date.civil 1391,  8, 31 }.to raise_error(ArgumentError, 'invalid date')

      # invalid type
      expect { Parsi::Date.civil '1390/1/1' }.to   raise_error(ArgumentError, 'invalid date')
      expect { Parsi::Date.civil 1391, '1', 9 }.to raise_error(ArgumentError, 'invalid date')
    end

    it "constructs a Date for 1/1/1 by default" do
      date = Parsi::Date.civil
      date.year.should  == 1
      date.month.should == 1
      date.day.should   == 1
    end
  end

  context "ordinal" do
    it "constructs a Date object from an ordinal date" do
      Parsi::Date.ordinal(1390).should       == Parsi::Date.civil(1390, 1, 1)
      Parsi::Date.ordinal(1390,7).should     == Parsi::Date.civil(1390, 1, 7)
      Parsi::Date.ordinal(1390,100).should   == Parsi::Date.civil(1390, 4, 7)
    end
  end

  context "parse" do
    it "should parse date from strings" do
      ['1391/8/6', '1391-8-6', '1391 8 6', '1391 8 6', '13910806'].each do |date_string|
        date = Parsi::Date.parse date_string
        [date.year, date.month, date.day].should == [1391, 8, 6]
      end
    end

    it "completes century when second arg is true" do
      Date.stub(:today) { Date.new 2012, 10, 26 }
      date = Parsi::Date.parse '91/8/5', true
      [date.year, date.month, date.day].should == [1391, 8, 5]
    end

    it "should raise ArgumentError on invalid date string" do
      expect { date = Parsi::Date.parse '1390/12/30' }.to      raise_error(ArgumentError)
      expect { date = Parsi::Date.parse 'bad date string' }.to raise_error(ArgumentError)
      expect { date = Parsi::Date.parse '12-30-1390' }.to      raise_error(ArgumentError)
    end
  end
end
