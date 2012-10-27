require File.expand_path('../../spec_helper', __FILE__)

describe "Parsi::Date#+" do
  it "adds the number of days to a Parsi::Date" do
    d = Parsi::Date.civil(1391, 2, 27) + 10
    d.should == Parsi::Date.civil(1391, 3, 6)
  end

  it "adds a negative number of days to a Parsi::Date" do
    d = Parsi::Date.civil(1391, 2, 27) + (-10)
    d.should == Parsi::Date.civil(1391, 2, 17)
  end

  it "raises a TypeError when passed a Symbol" do
    lambda { Parsi::Date.civil(1391, 2, 27) + :hello }.should raise_error(TypeError)
  end

  it "raises a TypeError when passed a String" do
    lambda { Parsi::Date.civil(1391, 2, 27) + "hello" }.should raise_error(TypeError)
  end

  it "raises a TypeError when passed a Parsi::Date" do
    lambda { Parsi::Date.civil(1391, 2, 27) + Parsi::Date.new }.should raise_error(TypeError)
  end

  it "raises a TypeError when passed an Object" do
    lambda { Parsi::Date.civil(1391, 2, 27) + Object.new }.should raise_error(TypeError)
  end
end