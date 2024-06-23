describe "Parsi::Date#step" do

  it "steps forward in time" do
    ds = Parsi::Date.civil(1391, 10, 11)
    de = Parsi::Date.civil(1391, 9, 29)
    count = 0
    de.step(ds) do |d|
      expect(d).to be <= ds
      expect(d).to be >= de
      count += 1
    end
    expect(count).to be == 13

    count = 0
    de.step(ds, 5) do |d|
      expect(d).to be <= ds
      expect(d).to be >= de
      count += 1
    end
    expect(count).to be == 3

    count = 0
    ds.step(de) do |d|; count += 1; end
    expect(count).to be == 0
  end

  it "steps backward in time" do
    ds = Parsi::Date.civil(1390, 4, 14)
    de = Parsi::Date.civil(1390, 3, 29)
    count = 0
    ds.step(de, -1) do |d|
      expect(d).to be <= ds
      expect(d).to be >= de
      count += 1
    end
    expect(count).to be == 17

    count = 0
    ds.step(de, -5) do |d|
      expect(d).to be <= ds
      expect(d).to be >= de
      count += 1
    end
    expect(count).to be == 4

    count = 0
    de.step(ds, -1) do |d|; count += 1; end
    expect(count).to be == 0
  end
end
