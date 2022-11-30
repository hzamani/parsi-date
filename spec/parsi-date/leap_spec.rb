describe "Parsi::Date#leap?" do
  it "returns true if a year is a leap year in the Parsi (Jalali) calendar" do
    expect Parsi::Date.leap?(1387) == true
    expect Parsi::Date.leap?(1391) == true
    expect Parsi::Date.leap?(1395) == true
    expect Parsi::Date.leap?(1403) == true
  end

  it "returns false if a year is not a leap year in the Parsi (Jalali) calendar" do
    expect Parsi::Date.leap?(1390) == false
    expect Parsi::Date.leap?(1392) == false
    expect Parsi::Date.leap?(1400) == false
    expect Parsi::Date.leap?(1404) == false
  end
end
