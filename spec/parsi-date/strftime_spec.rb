# encoding: utf-8
require File.expand_path('../../spec_helper', __FILE__)

describe "Parsi::Date#strftime" do

  it "should be able to print the date" do
    Parsi::Date.civil(1390, 4, 6).strftime.should == "1390/04/06"
  end

  it "should be able to print the full day name" do
    Parsi::Date.civil(1390, 4, 6).strftime("%A").should == "دوشنده"
  end

  it "should be able to print the short day name" do
    Parsi::Date.civil(1390, 4, 6).strftime("%a").should == "۲ش"
  end

  it "should be able to print the full month name" do
    Parsi::Date.civil(1390, 4, 6).strftime("%B").should == "تیر"
  end

  it "should be able to print the short month name" do
    Parsi::Date.civil(1390, 4, 6).strftime("%b").should == "Tir"
    Parsi::Date.civil(1390, 4, 6).strftime("%h").should == "Tir"
    Parsi::Date.civil(1390, 4, 6).strftime("%b").should == Parsi::Date.civil(1390, 4, 6).strftime("%h")
  end

  it "should be able to print the century" do
    Parsi::Date.civil(1390, 4, 6).strftime("%C").should == "13"
  end

  it "should be able to print the month day with leading zeroes" do
    Parsi::Date.civil(1390, 4, 6).strftime("%d").should == "06"
  end

  it "should be able to print the month day with leading spaces" do
    Parsi::Date.civil(1390, 4, 6).strftime("%e").should == " 6"
  end

  it "should be able to print the month with leading zeroes" do
    Parsi::Date.civil(1390, 4, 6).strftime("%m").should == "04"
  end

  it "should be able to add a newline" do
    Parsi::Date.civil(1390, 4, 6).strftime("%n").should == "\n"
  end

  it "should be able to add a tab" do
    Parsi::Date.civil(1390, 4, 6).strftime("%t").should == "\t"
  end

  it "should be able to show the week day" do
    Parsi::Date.civil(1390, 4, 11).strftime("%w").should == "6"
    Parsi::Date.civil(1390, 4, 12).strftime("%w").should == "0"
  end

  it "should be able to show the year in YYYY format" do
    Parsi::Date.civil(1390, 4, 9).strftime("%Y").should == "1390"
  end

  it "should be able to show the year in YY format" do
    Parsi::Date.civil(1390, 4, 9).strftime("%y").should == "90"
  end

  it "should be able to escape the % character" do
    Parsi::Date.civil(1390, 4, 9).strftime("%%").should == "%"
  end

  ############################
  # Specs that combine stuff #
  ############################

  it "should be able to print the date in full" do
    Parsi::Date.civil(1390, 4, 6).strftime("%c").should == "۲ش 6 تیر 1390"
    Parsi::Date.civil(1390, 4, 6).strftime("%c").should == Parsi::Date.civil(1390, 4, 6).strftime('%a %-d %B %Y')
  end

  it "should be able to print the date with slashes" do
    Parsi::Date.civil(1390, 4, 6).strftime("%D").should == "90/04/06"
    Parsi::Date.civil(1390, 4, 6).strftime("%D").should == Parsi::Date.civil(1390, 4, 6).strftime('%y/%m/%d')
  end

  it "should be able to print the date as YYYY-MM-DD" do
    Parsi::Date.civil(1390, 4, 6).strftime("%F").should == "1390-04-06"
    Parsi::Date.civil(1390, 4, 6).strftime("%F").should == Parsi::Date.civil(1390, 4, 6).strftime('%Y-%m-%d')
  end

  it "should be able to show the commercial week" do
    Parsi::Date.civil(1390, 4, 9).strftime("%v").should == " 9-Tir-1390"
    Parsi::Date.civil(1390, 4, 9).strftime("%v").should == Parsi::Date.civil(1390, 4, 9).strftime('%e-%b-%Y')
  end

  it "should be able to show YY/MM/DD" do
    Parsi::Date.civil(1390, 4, 6).strftime("%x").should == "90/04/06"
    Parsi::Date.civil(1390, 4, 6).strftime("%x").should == Parsi::Date.civil(1390, 4, 6).strftime('%y/%m/%d')
  end

end