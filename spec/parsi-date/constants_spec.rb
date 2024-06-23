# encoding: utf-8
describe "Date constants" do
  it "defines MONTHNAMES" do
    expect(Parsi::Date::MONTHNAMES).to be ==
      [nil] + %w(فروردین اردیبهشت خرداد تیر مرداد شهریور مهر آبان آذر دی بهمن اسفند)
  end

  it "defines EN_MONTHNAMES" do
    expect(Parsi::Date::EN_MONTHNAMES).to be ==
      [nil] + %w(farvardin ordibehesht khordad tir mordad shahrivar mehr aban azar day bahman esfand)
  end

  it "defines ABBR_MONTHNAMES" do
    expect(Parsi::Date::ABBR_MONTHNAMES).to be ==
      [nil] + %w(far ord kho tir mor sha meh abn azr day bah esf)
  end

  it "defines DAYNAMES" do
    expect(Parsi::Date::DAYNAMES).to be ==
      %w(یک‌شنبه دوشنبه سه‌شنبه چهارشنبه پنج‌شنبه جمعه شنبه)
  end

  it "defines EN_DAYNAMES" do
    expect(Parsi::Date::EN_DAYNAMES).to be ==
      %w(yekshanbe doshanbe seshanbe chaharshanbe panjshanbe jomee shanbe)
  end

  it "defines ABBR_DAYNAMES" do
    expect(Parsi::Date::ABBR_DAYNAMES).to be ==
      %w(۱ش ۲ش ۳ش ۴ش ۵ش ج ش)
  end

  it "defines ABBR_EN_DAYNAMES" do
    expect(Parsi::Date::ABBR_EN_DAYNAMES).to be ==
      %w(ye do se ch pj jo sh)
  end

  it "freezes MONTHNAMES, DAYNAMES, EN_DAYNAMES, ABBR_MONTHNAMES, ABBR_DAYSNAMES" do
    [Parsi::Date::MONTHNAMES, Parsi::Date::EN_MONTHNAMES, Parsi::Date::ABBR_MONTHNAMES,
     Parsi::Date::DAYNAMES, Parsi::Date::EN_DAYNAMES,
     Parsi::Date::ABBR_DAYNAMES, Parsi::Date::ABBR_EN_DAYNAMES].each do |array|
      expect(array).to be_frozen
    end
  end
end
