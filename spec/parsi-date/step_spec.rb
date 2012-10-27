require File.expand_path('../../spec_helper', __FILE__)

describe "Parsi::Date#step" do

  it "steps forward in time" do
    ds = Parsi::Date.civil(1391, 10, 11)
    de = Parsi::Date.civil(1391, 9, 29)
    count = 0
    de.step(ds) do |d|
      d.should <= ds
      d.should >= de
      count += 1
    end
    count.should == 13

    count = 0
    de.step(ds, 5) do |d|
      d.should <= ds
      d.should >= de
      count += 1
    end
    count.should == 3

    count = 0
    ds.step(de) do |d|; count += 1; end
    count.should == 0
  end

  it "steps backward in time" do
    ds = Parsi::Date.civil(1390, 4, 14)
    de = Parsi::Date.civil(1390, 3, 29)
    count = 0
    ds.step(de, -1) do |d|
      d.should <= ds
      d.should >= de
      count += 1
    end
    count.should == 17

    count = 0
    ds.step(de, -5) do |d|
      d.should <= ds
      d.should >= de
      count += 1
    end
    count.should == 4

    count = 0
    de.step(ds, -1) do |d|; count += 1; end
    count.should == 0
  end
end