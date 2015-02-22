require File.expand_path('../../spec_helper', __FILE__)

describe "Parsi::Date#cwday?" do
  it "returns the day of calendar week (1-7, Monday is 1)" do
    Parsi::Date.civil(1393, 12, 3).cwday.should == 7
    Parsi::Date.civil(1394,  1, 3).cwday.should == 1
  end
end

describe "Parsi::Date#cweek?" do
  it "returns the calendar week number (1-53)" do
    Parsi::Date.civil(1394, 1, 3).cweek.should == 1
    Parsi::Date.civil(1394, 1, 7).cweek.should == 1
    Parsi::Date.civil(1394, 1, 8).cweek.should == 2
  end
end
