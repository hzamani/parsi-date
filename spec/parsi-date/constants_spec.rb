# encoding: utf-8
require File.expand_path('../../spec_helper', __FILE__)

describe "Date constants" do
  it "defines MONTHNAMES" do
    Parsi::MONTHNAMES.should == [nil] + %w(فروردین اردیبهشت خرداد تیر مرداد شهریور مهر آبان آذر دی بهمن اسفند)
  end

  it "defines ABBR_MONTHNAMES" do
    Parsi::ABBR_MONTHNAMES.should == [nil] + %w(Far Ord Kho Tir Mor Sha Meh Abn Azr Dey Bah Esf)
  end

  it "defines DAYNAMES" do
    Parsi::DAYNAMES.should == %w(شنده یک‌شنده دوشنده سه‌شنده چهارشنده چنج‌شنده جمعه)
  end

  it "defines ABBR_DAYNAMES" do
    Parsi::ABBR_DAYNAMES.should == %w(ش ۱ش ۲ش ۳ش ۴ش ۵ش ج)
  end

  it "freezes MONTHNAMES, DAYNAMES, ABBR_MONTHNAMES, ABBR_DAYSNAMES" do
    [Parsi::MONTHNAMES, Parsi::DAYNAMES, Parsi::ABBR_MONTHNAMES, Parsi::ABBR_DAYNAMES].each do |ary|
      ary.should be_frozen
    end
  end
end