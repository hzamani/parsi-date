describe "Parsi::Date#leap?" do
  it "returns true if a year is a leap year in the Parsi (Jalali) calendar" do
    Parsi::Date.leap?(1387).should be_truthy
    Parsi::Date.leap?(1391).should be_truthy
    Parsi::Date.leap?(1395).should be_truthy
  end

  it "returns false if a year is not a leap year in the Parsi (Jalali) calendar" do
    Parsi::Date.leap?(1390).should be_falsey
    Parsi::Date.leap?(1392).should be_falsey
    Parsi::Date.leap?(1400).should be_falsey
  end
end
