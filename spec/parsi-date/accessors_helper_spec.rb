require 'sqlite3'
require 'active_record'

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'dbfile.sqlite3')

ActiveRecord::Schema.verbose = false
ActiveRecord::Schema.define do
  if !table_exists? :models
    create_table :models do |t|
      t.date :start_date
    end
  end
end

class Model < ActiveRecord::Base
  extend Parsi::DateAccessors
  parsi_date_accessor :start_date
end

class Record
  extend Parsi::DateAccessors
  attr_accessor :created_at, :updated_at
  parsi_date_accessor :created_at, :updated_at
end

describe "Record extended with Parsi::Date::Accessors" do
  it "has parsi postfixed accessor for giver attributes" do
    record = Record.new
    [:created_at_parsi, :created_at_parsi=, :updated_at_parsi, :updated_at_parsi].each do |name|
      expect(record.respond_to?(name)).to be_truthy
    end
  end

  describe "created getter" do
    it "returen given date converted to jalali" do
      record = Record.new
      record.created_at = Date.today
      expect(record.created_at_parsi).to be == Parsi::Date.today
    end
  end

  describe "created setter" do
    it "sets date attribute to given date concerted to gregorian" do
      record = Record.new
      record.created_at_parsi = Parsi::Date.today
      expect(record.created_at).to be == Date.today
    end

    context "with string arg" do
      it "sets date attribute to given date when parsable" do
        record = Record.new
        record.created_at_parsi = "1393-12-12"
        date = Parsi::Date.parse "1393-12-12"
        expect(record.created_at_parsi).to be == date
        expect(record.created_at).to be == date.to_gregorian
      end

      it "raises error when string is not a date" do
        record = Record.new
        expect {record.created_at_parsi = "1393-13-11" }.to raise_error(ArgumentError)
      end
    end
  end

  context "for active_record subclasses" do
    it "saves attributes to datebase" do
      model = Model.new start_date_parsi: Parsi::Date.today
      expect(model[:start_date]).to be == Date.today
      model.save
      expect(Model.first.start_date).to be == Date.today
    end
  end
end
