describe "Parsi::Date#ajd" do
  it "determines the Astronomical Julian day" do
    expect(Parsi::Date.civil(1391, 8, 6).ajd).to be == Rational(4912455, 2)
    expect(Parsi::Date.civil(1403, 12, 30).ajd).to be == Rational(4921509, 2)
  end
end

describe "Parsi::Date#amjd" do
  it "determines the Astronomical Modified Julian day" do
    expect(Parsi::Date.civil(1391, 8, 6).amjd).to be == 56227
    expect(Parsi::Date.civil(1403, 12, 30).amjd).to be == 60754
  end
end

describe "Parsi::Date#mjd" do
  it "determines the Modified Julian day" do
    expect(Parsi::Date.civil(1391, 8, 6).mjd).to be == 56227
    expect(Parsi::Date.civil(1403, 12, 30).mjd).to be == 60754
  end
end

describe "Parsi::Date#ld" do
  it "determines the number of days since the Day of Calendar Reform" do
    expect(Parsi::Date.civil(1391, 8, 6).ld).to be == 157068
    expect(Parsi::Date.civil(1403, 12, 30).ld).to be == 161595
  end
end

describe "Parsi::Date#year" do
  it "determines the year" do
    expect(Parsi::Date.civil(1391, 8, 6).year).to be == 1391
    expect(Parsi::Date.civil(1403, 12, 30).year).to be == 1403
  end
end

describe "Parsi::Date#yday" do
  it "determines the year" do
    expect(Parsi::Date.civil(1391, 1, 17).yday).to be == 17
    expect(Parsi::Date.civil(1391, 8, 6).yday).to be == 222
    expect(Parsi::Date.civil(1403, 12, 30).yday).to be == 366
  end
end

describe "Parsi::Date#mon" do
  it "determines the month" do
    expect(Parsi::Date.civil(1391, 1, 17).mon).to be == 1
    expect(Parsi::Date.civil(1391, 8, 6).mon).to be == 8
    expect(Parsi::Date.civil(1403, 12, 30).mon).to be == 12
  end
end

describe "Parsi::Date#mday" do
  it "determines the day of the month" do
    expect(Parsi::Date.civil(1391, 1, 17).mday).to be == 17
    expect(Parsi::Date.civil(1391, 10, 28).mday).to be == 28
    expect(Parsi::Date.civil(1403, 12, 30).mday).to be == 30
  end
end

describe "Parsi::Date#wday" do
  it "determines the week day" do
    expect(Parsi::Date.civil(1391, 1, 17).wday).to be == 4
    expect(Parsi::Date.civil(1391, 8, 6).wday).to be == 6
    expect(Parsi::Date.civil(1403, 12, 30).wday).to be == 4
  end
end
