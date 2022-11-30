# encoding: utf-8
describe "Parsi::Date#strftime" do

  it "is able to print the date" do
    expect Parsi::Date.civil(1390, 4, 6).strftime == "1390/04/06"
  end

  it "is able to print the full day name" do
    expect Parsi::Date.civil(1390, 4, 6).strftime("%A") == "دوشنبه"
  end

  it "is able to print the short day name" do
    expect Parsi::Date.civil(1390, 4, 6).strftime("%a") == "۲ش"
  end

  it "is able to print the full month name" do
    expect Parsi::Date.civil(1390, 4, 6).strftime("%B") == "تیر"
    expect Parsi::Date.civil(1390, 4, 6).strftime("%EB") == "tir"
    expect Parsi::Date.civil(1390, 4, 6).strftime("%^EB") == "Tir"
  end

  it "is able to print the short month name" do
    expect Parsi::Date.civil(1390, 4, 6).strftime("%b") == "tir"
    expect Parsi::Date.civil(1390, 4, 6).strftime("%h") == "tir"
    expect Parsi::Date.civil(1390, 4, 6).strftime("%^b") == "Tir"
    expect Parsi::Date.civil(1390, 4, 6).strftime("%^h") == "Tir"
    expect Parsi::Date.civil(1390, 4, 6).strftime("%b") == Parsi::Date.civil(1390, 4, 6).strftime("%h")
  end

  it "is able to print the century" do
    expect Parsi::Date.civil(1390, 4, 6).strftime("%C") == "13"
  end

  it "is able to print the month day with leading zeroes" do
    expect Parsi::Date.civil(1390, 4,  6).strftime("%d") == "06"
    expect Parsi::Date.civil(1390, 4, 16).strftime("%d") == "16"
  end

  it "is able to print the month day with leading spaces and without em" do
    expect Parsi::Date.civil(1390, 4,  6).strftime("%-d") == "6"
    expect Parsi::Date.civil(1390, 4,  6).strftime("%e") == " 6"
    expect Parsi::Date.civil(1390, 4, 16).strftime("%e") == "16"
  end

  it "is able to print the month with leading zeroes, spaces and none" do
    expect Parsi::Date.civil(1390,  4, 6).strftime("%m") == "04"
    expect Parsi::Date.civil(1390, 11, 6).strftime("%m") == "11"
    expect Parsi::Date.civil(1390,  4, 6).strftime("%_m") == " 4"
    expect Parsi::Date.civil(1390, 11, 6).strftime("%_m") == "11"
    expect Parsi::Date.civil(1390,  4, 6).strftime("%-m") == "4"
    expect Parsi::Date.civil(1390, 11, 6).strftime("%-m") == "11"
  end

  it "is able to add a newline" do
    expect Parsi::Date.civil(1390, 4, 6).strftime("%n") == "\n"
  end

  it "is able to add a tab" do
    expect Parsi::Date.civil(1390, 4, 6).strftime("%t") == "\t"
  end

  it "is able to show the week day" do
    expect Parsi::Date.civil(1390, 4, 11).strftime("%w") == "6"
    expect Parsi::Date.civil(1390, 4, 12).strftime("%w") == "0"
  end

  it "is able to show the year in YYYY format" do
    expect Parsi::Date.civil(1390, 4, 9).strftime("%Y") == "1390"
  end

  it "is able to show the year in YY format" do
    expect Parsi::Date.civil(1390, 4, 9).strftime("%y") == "90"
  end

  it "is able to escape the % character" do
    expect Parsi::Date.civil(1390, 4, 9).strftime("%%") == "%"
  end

  ############################
  # Specs that combine stuff #
  ############################

  it "is able to print the date in full" do
    expect Parsi::Date.civil(1390, 4, 6).strftime("%c") == "۲ش 6 تیر 1390"
    expect Parsi::Date.civil(1390, 4, 6).strftime("%c") == Parsi::Date.civil(1390, 4, 6).strftime('%a %-d %B %Y')
  end

  it "is able to print the date with slashes" do
    expect Parsi::Date.civil(1390, 4, 6).strftime("%D") == "90/04/06"
    expect Parsi::Date.civil(1390, 4, 6).strftime("%D") == Parsi::Date.civil(1390, 4, 6).strftime('%y/%m/%d')
  end

  it "is able to print the date as YYYY-MM-DD" do
    expect Parsi::Date.civil(1390, 4, 6).strftime("%F") == "1390-04-06"
    expect Parsi::Date.civil(1390, 4, 6).strftime("%F") == Parsi::Date.civil(1390, 4, 6).strftime('%Y-%m-%d')
  end

  it "is able to show the commercial week" do
    expect Parsi::Date.civil(1390, 4, 9).strftime("%v") == " 9-تیر-1390"
    expect Parsi::Date.civil(1390, 4, 9).strftime("%v") == Parsi::Date.civil(1390, 4, 9).strftime('%e-%B-%Y')
  end

  it "is able to show YY/MM/DD" do
    expect Parsi::Date.civil(1390, 4, 6).strftime("%x") == "90/04/06"
    expect Parsi::Date.civil(1390, 4, 6).strftime("%x") == Parsi::Date.civil(1390, 4, 6).strftime('%y/%m/%d')
  end

end
