describe "Parsi::Date#>>" do
  it "adds the number of months to a Parsi::Date" do
    expect (Parsi::Date.civil(1391, 2, 27) >> 10) == Parsi::Date.civil(1391, 12, 27)
  end

  it "sets the day to the last day of a month if the day doesn't exist" do
    expect (Parsi::Date.civil(1391, 6, 31) >> 1) == Parsi::Date.civil(1391, 7, 30)
  end

  it "raise a TypeError when passed a Symbol" do
    expect { Parsi::Date.civil(1391, 2, 27) >> :hello }.to raise_error(TypeError)
  end

  it "raise a TypeError when passed a String" do
    expect { Parsi::Date.civil(1391, 2, 27) >> "hello" }.to raise_error(TypeError)
  end

  it "raise a TypeError when passed a Parsi::Date" do
    expect { Parsi::Date.civil(1391, 2, 27) >> Parsi::Date.new }.to raise_error(TypeError)
  end

  it "raise a TypeError when passed an Object" do
    expect { Parsi::Date.civil(1391, 2, 27) >> Object.new }.to raise_error(TypeError)
  end
end
