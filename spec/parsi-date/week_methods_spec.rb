describe "Parsi::Date#cwday?" do
  it "returns the day of calendar week (1-7, Monday is 1)" do
    expect Parsi::Date.civil(1393, 12, 3).cwday == 7
    expect Parsi::Date.civil(1394,  1, 3).cwday == 1
  end
end

describe "Parsi::Date#cweek?" do
  it "returns the calendar week number (1-53)" do
    expect Parsi::Date.civil(1393, 11, 30).cweek == 48
    expect Parsi::Date.civil(1393, 12, 1).cweek == 48
    expect Parsi::Date.civil(1393, 12, 29).cweek == 52
    expect Parsi::Date.civil(1394, 1, 1).cweek == 1
    expect Parsi::Date.civil(1394, 1, 7).cweek == 1
    expect Parsi::Date.civil(1394, 1, 8).cweek == 2
  end
end
