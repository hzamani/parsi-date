# encoding: utf-8
describe "Parsi::Date#strftime" do

  it "is able to print the date" do
    expect(Parsi::Date.civil(1390, 4, 6).strftime).to be == "1390/04/06"
  end

  it "is able to print the full day name" do
    expect(Parsi::Date.civil(1390, 4, 6).strftime("%A")).to be == "دوشنبه"
  end

  it "is able to print the short day name" do
    expect(Parsi::Date.civil(1390, 4, 6).strftime("%a")).to be == "۲ش"
  end

  it "is able to print the full month name" do
    expect(Parsi::Date.civil(1390, 4, 6).strftime("%B")  ).to be == "تیر"
    expect(Parsi::Date.civil(1390, 4, 6).strftime("%EB") ).to be == "tir"
    expect(Parsi::Date.civil(1390, 4, 6).strftime("%^EB")).to be == "Tir"
  end

  it "is able to print the short month name" do
    expect(Parsi::Date.civil(1390, 4, 6).strftime("%b") ).to be == "tir"
    expect(Parsi::Date.civil(1390, 4, 6).strftime("%h") ).to be == "tir"
    expect(Parsi::Date.civil(1390, 4, 6).strftime("%^b")).to be == "Tir"
    expect(Parsi::Date.civil(1390, 4, 6).strftime("%^h")).to be == "Tir"
    expect(Parsi::Date.civil(1390, 4, 6).strftime("%b") ).to be == Parsi::Date.civil(1390, 4, 6).strftime("%h")
  end

  it "is able to print the century" do
    expect(Parsi::Date.civil(1390, 4, 6).strftime("%C")).to be == "13"
  end

  it "is able to print the month day with leading zeroes" do
    expect(Parsi::Date.civil(1390, 4,  6).strftime("%d")).to be == "06"
    expect(Parsi::Date.civil(1390, 4, 16).strftime("%d")).to be == "16"
  end

  it "is able to print the month day with leading spaces and without em" do
    expect(Parsi::Date.civil(1390, 4,  6).strftime("%-d")).to be == "6"
    expect(Parsi::Date.civil(1390, 4,  6).strftime("%e") ).to be == " 6"
    expect(Parsi::Date.civil(1390, 4, 16).strftime("%e") ).to be == "16"
  end

  it "is able to print the month with leading zeroes, spaces and none" do
    expect(Parsi::Date.civil(1390,  4, 6).strftime("%m") ).to be == "04"
    expect(Parsi::Date.civil(1390, 11, 6).strftime("%m") ).to be == "11"
    expect(Parsi::Date.civil(1390,  4, 6).strftime("%_m")).to be == " 4"
    expect(Parsi::Date.civil(1390, 11, 6).strftime("%_m")).to be == "11"
    expect(Parsi::Date.civil(1390,  4, 6).strftime("%-m")).to be == "4"
    expect(Parsi::Date.civil(1390, 11, 6).strftime("%-m")).to be == "11"
  end

  it "is able to add a newline" do
    expect(Parsi::Date.civil(1390, 4, 6).strftime("%n")).to be == "\n"
  end

  it "is able to add a tab" do
    expect(Parsi::Date.civil(1390, 4, 6).strftime("%t")).to be == "\t"
  end

  it "is able to show the week day" do
    expect(Parsi::Date.civil(1390, 4, 11).strftime("%w")).to be == "6"
    expect(Parsi::Date.civil(1390, 4, 12).strftime("%w")).to be == "0"
  end

  it "is able to show the year in YYYY format" do
    expect(Parsi::Date.civil(1390, 4, 9).strftime("%Y")).to be == "1390"
  end

  it "is able to show the year in YY format" do
    expect(Parsi::Date.civil(1390, 4, 9).strftime("%y")).to be == "90"
  end

  it "is able to escape the % character" do
    expect(Parsi::Date.civil(1390, 4, 9).strftime("%%")).to be == "%"
  end

  ############################
  # Specs that combine stuff #
  ############################

  it "is able to print the date in full" do
    expect(Parsi::Date.civil(1390, 4, 6).strftime("%c")).to be == "۲ش 6 تیر 1390"
    expect(Parsi::Date.civil(1390, 4, 6).strftime("%c")).to be == Parsi::Date.civil(1390, 4, 6).strftime('%a %-d %B %Y')
  end

  it "is able to print the date with slashes" do
    expect(Parsi::Date.civil(1390, 4, 6).strftime("%D")).to be == "90/04/06"
    expect(Parsi::Date.civil(1390, 4, 6).strftime("%D")).to be == Parsi::Date.civil(1390, 4, 6).strftime('%y/%m/%d')
  end

  it "is able to print the date as YYYY-MM-DD" do
    expect(Parsi::Date.civil(1390, 4, 6).strftime("%F")).to be == "1390-04-06"
    expect(Parsi::Date.civil(1390, 4, 6).strftime("%F")).to be == Parsi::Date.civil(1390, 4, 6).strftime('%Y-%m-%d')
  end

  it "is able to show the commercial week" do
    expect(Parsi::Date.civil(1390, 4, 9).strftime("%v")).to be == " 9-تیر-1390"
    expect(Parsi::Date.civil(1390, 4, 9).strftime("%v")).to be == Parsi::Date.civil(1390, 4, 9).strftime('%e-%B-%Y')
  end

  it "is able to show YY/MM/DD" do
    expect(Parsi::Date.civil(1390, 4, 6).strftime("%x")).to be == "90/04/06"
    expect(Parsi::Date.civil(1390, 4, 6).strftime("%x")).to be == Parsi::Date.civil(1390, 4, 6).strftime('%y/%m/%d')
  end

end
