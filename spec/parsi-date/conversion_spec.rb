describe "Parsi::Date.jd" do
  it "constructs a date form given Chronological Julian day number" do
    expect Parsi::Date.jd(2456228) == Parsi::Date.civil(1391, 8, 6)
    expect Parsi::Date.jd(2456229) == Parsi::Date.civil(1391, 8, 7)
  end

  it "returns a Date object representing Julian day 0 if no arguments passed"do
    expect Parsi::Date.jd == Parsi::Date.civil(-5334, 9, 1)
  end

  it "constructs a Date object if passed a negative number" do
    expect Parsi::Date.jd(-1) == Parsi::Date.civil(-5334, 8, 30)
  end
end

describe "Parsi::Date#jd" do
  it "determines the Julian day for a Date object" do
    expect Parsi::Date.civil(1391, 8, 7).jd == 2456229
  end
end

describe "Parsi::Date#to_gregorian" do
  it "converts date to Gregorian date" do
    date = Parsi::Date.civil(1391, 8, 7).to_gregorian
    expect(date).to be_a(Date)
    expect date == Date.civil(2012, 10, 28)
  end
end

describe "Date#to_parsi" do
  it "converts date to Parsi date" do
    date = Date.civil(2012, 10, 28).to_parsi
    expect(date).to be_a(Parsi::Date)
    expect date == Parsi::Date.civil(1391, 8, 7)
  end
end
