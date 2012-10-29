require File.expand_path('../../spec_helper', __FILE__)

describe "Parsi::Date.jd" do
  it "constructs a date form given Chronological Julian day number" do
    Parsi::Date.jd(2456228).should == Parsi::Date.civil(1391, 8, 6)
    Parsi::Date.jd(2456229).should == Parsi::Date.civil(1391, 8, 7)
  end

  it "returns a Date object representing Julian day 0 if no arguments passed"do
    Parsi::Date.jd.should == Parsi::Date.civil(-5334, 9, 1)
  end

  it "constructs a Date object if passed a negative number" do
    Parsi::Date.jd(-1).should == Parsi::Date.civil(-5334, 8, 30)
  end
end

describe "Parsi::Date#jd" do
  it "determines the Julian day for a Date object" do
    Parsi::Date.civil(1391, 8, 7).jd.should == 2456229
  end
end

describe "Parsi::Date#to_gregorian" do
  it "converts date to Gregorian date" do
    date = Parsi::Date.civil(1391, 8, 7).to_gregorian
    date.should be_a(Date)
    date.should == Date.civil(2012, 10, 28)
  end
end

describe "Date#to_parsi" do
  it "converts date to Parsi date" do
    date = Date.civil(2012, 10, 28).to_parsi
    date.should be_a(Parsi::Date)
    date.should == Parsi::Date.civil(1391, 8, 7)
  end
end