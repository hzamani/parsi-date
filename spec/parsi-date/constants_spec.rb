# encoding: utf-8
require File.expand_path('../../spec_helper', __FILE__)

describe "Date constants" do
  it "defines MONTHNAMES" do
    Parsi::Date::MONTHNAMES.should == [nil] + %w(فروردین اردیبهشت خرداد تیر مرداد شهریور مهر آبان آذر دی بهمن اسفند)
  end

  it "defines ABBR_MONTHNAMES" do
    Parsi::Date::ABBR_MONTHNAMES.should == [nil] + %w(Far Ord Kho Tir Mor Sha Meh Abn Azr Dey Bah Esf)
  end

  it "defines DAYNAMES" do
    Parsi::Date::DAYNAMES.should == %w(یک‌شنده دوشنده سه‌شنده چهارشنده چنج‌شنده جمعه شنده )
  end

  it "defines ABBR_DAYNAMES" do
    Parsi::Date::ABBR_DAYNAMES.should == %w(۱ش ۲ش ۳ش ۴ش ۵ش ج ش)
  end

  it "freezes MONTHNAMES, DAYNAMES, ABBR_MONTHNAMES, ABBR_DAYSNAMES" do
    [Parsi::Date::MONTHNAMES, Parsi::Date::DAYNAMES, Parsi::Date::ABBR_MONTHNAMES, Parsi::Date::ABBR_DAYNAMES].each do |ary|
      ary.should be_frozen
    end
  end
end