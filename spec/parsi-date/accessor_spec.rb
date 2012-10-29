require File.expand_path('../../spec_helper', __FILE__)

describe "Parsi::Date#ajd" do
  it "determines the Astronomical Julian day" do
    Parsi::Date.civil(1391, 8, 6).ajd.should == Rational(4912455, 2)
  end
end

describe "Parsi::Date#amjd" do
  it "determines the Astronomical Modified Julian day" do
    Parsi::Date.civil(1391, 8, 6).amjd.should == 56227
  end
end

describe "Parsi::Date#mjd" do
  it "determines the Modified Julian day" do
    Parsi::Date.civil(1391, 8, 6).mjd.should == 56227
  end
end

describe "Parsi::Date#ld" do
  it "determines the Modified Julian day" do
    Parsi::Date.civil(1391, 8, 6).ld.should == 157068
  end
end

describe "Parsi::Date#year" do
  it "determines the year" do
    Parsi::Date.civil(1391, 8, 6).year.should == 1391
  end
end

describe "Parsi::Date#yday" do
  it "determines the year" do
    Parsi::Date.civil(1391, 1, 17).yday.should == 17
    Parsi::Date.civil(1391, 8, 6).yday.should == 222
  end
end

describe "Parsi::Date#mon" do
  it "determines the month" do
    Parsi::Date.civil(1391, 1, 17).mon.should == 1
    Parsi::Date.civil(1391, 8, 6).mon.should == 8
  end
end

describe "Parsi::Date#mday" do
  it "determines the day of the month" do
    Parsi::Date.civil(1391, 1, 17).mday.should == 17
    Parsi::Date.civil(1391, 10, 28).mday.should == 28
  end
end

describe "Parsi::Date#wday" do
  it "determines the week day" do
    Parsi::Date.civil(1391, 1, 17).wday.should == 4
    Parsi::Date.civil(1391, 8, 6).wday.should == 6
  end
end
