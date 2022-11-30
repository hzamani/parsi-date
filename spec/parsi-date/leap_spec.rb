describe "Parsi::Date#leap?" do
  it "returns true if a year is a leap year in the Parsi (Jalali) calendar" do
    expect(Parsi::Date.leap?(1387)).to be_truthy
    expect(Parsi::Date.leap?(1391)).to be_truthy
    expect(Parsi::Date.leap?(1395)).to be_truthy
  end

  it "returns false if a year is not a leap year in the Parsi (Jalali) calendar" do
    expect(Parsi::Date.leap?(1390)).to be_falsey
    expect(Parsi::Date.leap?(1392)).to be_falsey
    expect(Parsi::Date.leap?(1400)).to be_falsey
  end
end
