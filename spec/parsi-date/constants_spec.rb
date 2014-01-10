# encoding: utf-8
require File.expand_path('../../spec_helper', __FILE__)

describe "Date constants" do
  it "defines MONTHNAMES" do
    Parsi::Date::MONTHNAMES.should == [nil] +
      %w(فروردین اردیبهشت خرداد تیر مرداد شهریور مهر آبان آذر دی بهمن اسفند)
  end

  it "defines EN_MONTHNAMES" do
    Parsi::Date::EN_MONTHNAMES.should == [nil] +
      %w(farvardin ordibehesht khordad tir mordad shahrivar mehr aban azar day bahman esfand)
  end

  it "defines ABBR_MONTHNAMES" do
    Parsi::Date::ABBR_MONTHNAMES.should == [nil] +
      %w(far ord kho tir mor sha meh abn azr day bah esf)
  end

  it "defines DAYNAMES" do
    Parsi::Date::DAYNAMES.should == %w(یک‌شنبه دوشنبه سه‌شنبه چهارشنبه پنج‌شنبه جمعه شنبه)
  end

  it "defines EN_DAYNAMES" do
    Parsi::Date::EN_DAYNAMES.should == %w(yekshanbe doshanbe seshanbe chaharshanbe panjshanbe jomee shanbe)
  end

  it "defines ABBR_DAYNAMES" do
    Parsi::Date::ABBR_DAYNAMES.should == %w(۱ش ۲ش ۳ش ۴ش ۵ش ج ش)
  end

  it "defines ABBR_EN_DAYNAMES" do
    Parsi::Date::ABBR_EN_DAYNAMES.should == %w(ye do se ch pj jo sh)
  end

  it "freezes MONTHNAMES, DAYNAMES, EN_DAYNAMES, ABBR_MONTHNAMES, ABBR_DAYSNAMES" do
    [Parsi::Date::MONTHNAMES, Parsi::Date::EN_MONTHNAMES, Parsi::Date::ABBR_MONTHNAMES,
     Parsi::Date::DAYNAMES, Parsi::Date::EN_DAYNAMES,
     Parsi::Date::ABBR_DAYNAMES, Parsi::Date::ABBR_EN_DAYNAMES].each do |ary|
      ary.should be_frozen
    end
  end
end
