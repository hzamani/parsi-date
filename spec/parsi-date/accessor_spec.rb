describe "Parsi::Date#ajd" do
  it "determines the Astronomical Julian day" do
    expect Parsi::Date.civil(1391, 8, 6).ajd == Rational(4912455, 2)
  end
end

describe "Parsi::Date#amjd" do
  it "determines the Astronomical Modified Julian day" do
    expect Parsi::Date.civil(1391, 8, 6).amjd == 56227
  end
end

describe "Parsi::Date#mjd" do
  it "determines the Modified Julian day" do
    expect Parsi::Date.civil(1391, 8, 6).mjd == 56227
  end
end

describe "Parsi::Date#ld" do
  it "determines the Modified Julian day" do
    expect Parsi::Date.civil(1391, 8, 6).ld == 157068
  end
end

describe "Parsi::Date#year" do
  it "determines the year" do
    expect Parsi::Date.civil(1391, 8, 6).year == 1391
  end
end

describe "Parsi::Date#yday" do
  it "determines the year" do
    expect Parsi::Date.civil(1391, 1, 17).yday == 17
    expect Parsi::Date.civil(1391, 8, 6).yday == 222
  end
end

describe "Parsi::Date#mon" do
  it "determines the month" do
    expect Parsi::Date.civil(1391, 1, 17).mon == 1
    expect Parsi::Date.civil(1391, 8, 6).mon == 8
  end
end

describe "Parsi::Date#mday" do
  it "determines the day of the month" do
    expect Parsi::Date.civil(1391, 1, 17).mday == 17
    expect Parsi::Date.civil(1391, 10, 28).mday == 28
  end
end

describe "Parsi::Date#wday" do
  it "determines the week day" do
    expect Parsi::Date.civil(1391, 1, 17).wday == 4
    expect Parsi::Date.civil(1391, 8, 6).wday == 6
  end
end
