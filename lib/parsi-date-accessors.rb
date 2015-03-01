module Parsi::DateAccessors
  def parsi_date_accessor(*names)
    names.each do |name|
      define_method("#{name}_parsi") do
        send(name).to_parsi rescue nil
      end

      define_method("#{name}_parsi=") do |value|
        value = Parsi::Date.parse(value) if value.is_a?(String)
        send("#{name}=", value.to_gregorian)
      end
    end
  end
end
