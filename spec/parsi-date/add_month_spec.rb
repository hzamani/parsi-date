require File.expand_path('../../spec_helper', __FILE__)

describe "Parsi::Date#>>" do
  it "adds the number of months to a Parsi::Date" do
    d = Parsi::Date.civil(1391, 2, 27) >> 10
    d.should == Parsi::Date.civil(1391, 12, 27)
  end

  it "sets the day to the last day of a month if the day doesn't exist" do
    d = Parsi::Date.civil(1391, 6, 31) >> 1
    d.should == Parsi::Date.civil(1391, 7, 30)
  end

  it "raise a TypeError when passed a Symbol" do
    lambda { Parsi::Date.civil(1391, 2, 27) >> :hello }.should raise_error(TypeError)
  end

  it "raise a TypeError when passed a String" do
    lambda { Parsi::Date.civil(1391, 2, 27) >> "hello" }.should raise_error(TypeError)
  end

  it "raise a TypeError when passed a Parsi::Date" do
    lambda { Parsi::Date.civil(1391, 2, 27) >> Parsi::Date.new }.should raise_error(TypeError)
  end

  it "raise a TypeError when passed an Object" do
    lambda { Parsi::Date.civil(1391, 2, 27) >> Object.new }.should raise_error(TypeError)
  end
end