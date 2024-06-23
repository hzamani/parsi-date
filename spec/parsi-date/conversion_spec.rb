describe "Parsi::Date.jd" do
  it "constructs a date form given Chronological Julian day number" do
    expect(Parsi::Date.jd(2456228)).to be == Parsi::Date.civil(1391, 8, 6)
    expect(Parsi::Date.jd(2456229)).to be == Parsi::Date.civil(1391, 8, 7)
    expect(Parsi::Date.jd(2456229)).to be == Parsi::Date.civil(1391, 8, 7)
    expect(Parsi::Date.jd(2460755)).to be == Parsi::Date.civil(1403, 12, 30)
    expect(Parsi::Date.jd(2460756)).to be == Parsi::Date.civil(1404, 1, 1)
  end

  it "returns a Date object representing Julian day 0 if no arguments passed"do
    expect(Parsi::Date.jd).to be == Parsi::Date.civil(-5334, 9, 3)
  end

  it "constructs a Date object if passed a negative number" do
    expect(Parsi::Date.jd(-1)).to be == Parsi::Date.civil(-5334, 9, 2)
  end
end

describe "Parsi::Date#jd" do
  it "determines the Julian day for a Date object" do
    expect(Parsi::Date.civil(1391, 8, 7).jd  ).to be == 2456229
    expect(Parsi::Date.civil(1403, 12, 30).jd).to be == 2460755
    expect(Parsi::Date.civil(1404, 1, 1).jd  ).to be == 2460756
  end
end

describe "Parsi::Date#to_gregorian" do
  it "converts date to Gregorian date" do
    date = Parsi::Date.civil(1391, 8, 7).to_gregorian
    expect(date).to be_a(Date)
    expect(date).to be == Date.civil(2012, 10, 28)

    expect(Parsi::Date.civil(1366, 11, 14).to_gregorian).to be == Date.civil(1988, 2, 3)
    expect(Parsi::Date.civil(1403, 12, 30).to_gregorian).to be == Date.civil(2025, 3, 20)
  end
end

describe "Date#to_parsi" do
  it "converts date to Parsi date" do
    date = Date.civil(2012, 10, 28).to_parsi
    expect(date).to be_a(Parsi::Date)
    expect(date).to be == Parsi::Date.civil(1391, 8, 7)

    expect(Date.civil(1988, 2, 3).to_parsi ).to be == Parsi::Date.civil(1366, 11, 14)
    expect(Date.civil(2025, 3, 20).to_parsi).to be == Parsi::Date.civil(1403, 12, 30)
  end
end
