describe "Parsi::Date#+" do
  it "adds the number of days to a Parsi::Date" do
    expect Parsi::Date.civil(1391, 2, 27) + 10 == Parsi::Date.civil(1391, 3, 6)
  end

  it "adds a negative number of days to a Parsi::Date" do
    expect Parsi::Date.civil(1391, 2, 27) + (-10) == Parsi::Date.civil(1391, 2, 17)
  end

  it "raises a TypeError when passed a Symbol" do
    expect { Parsi::Date.civil(1391, 2, 27) + :hello }.to raise_error(TypeError)
  end

  it "raises a TypeError when passed a String" do
    expect { Parsi::Date.civil(1391, 2, 27) + "hello" }.to raise_error(TypeError)
  end

  it "raises a TypeError when passed a Parsi::Date" do
    expect { Parsi::Date.civil(1391, 2, 27) + Parsi::Date.new }.to raise_error(TypeError)
  end

  it "raises a TypeError when passed an Object" do
    expect { Parsi::Date.civil(1391, 2, 27) + Object.new }.to raise_error(TypeError)
  end
end
