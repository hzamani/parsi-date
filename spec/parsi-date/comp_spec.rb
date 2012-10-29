require File.expand_path('../../spec_helper', __FILE__)
require 'date'

describe "Parsi::Date#<=>" do
  it "returns 0 when two dates are equal" do
    (Parsi::Date.civil(1391, 4, 6) <=> Parsi::Date.civil(1391, 4, 6)).should == 0
    (Parsi::Date.civil(1391, 4, 6) <=> Date.civil(2012, 6, 26)).should == 0
  end

  it "returns -1 when self is less than another date" do
    (Parsi::Date.civil(1391, 4, 5) <=> Parsi::Date.civil(1391, 4, 6)).should == -1
    (Parsi::Date.civil(1391, 4, 5) <=> Date.civil(2012, 6, 26)).should == -1
  end

  it "returns 1 when self is greater than another date" do
    (Parsi::Date.civil(1392, 4, 7) <=> Parsi::Date.civil(1391, 4, 6)).should == 1
    (Parsi::Date.civil(1391, 4, 7) <=> Date.civil(2012, 6, 26)).should == 1
  end

  it "returns 0 when self is equal to a Numeric" do
    (Parsi::Date.civil(1391, 4, 6) <=> Rational(4912209,2)).should == 0
  end

  it "returns -1 when self is less than a Numeric" do
    (Parsi::Date.civil(1391, 4, 6) <=> Rational(4912210,2)).should == -1
  end

  it "returns 1 when self is greater than a Numeric" do
    (Parsi::Date.civil(1391, 4, 6) <=> Rational(4912208,2)).should == 1
  end
end