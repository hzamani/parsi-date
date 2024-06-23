# Parsi Date

The Parsi Date library is an implementation of the [Solar Hijri Calendar](http://en.wikipedia.org/wiki/Solar_Hijri_calendar), also known as the Jalali or Persian Calendar, which is the official calendar of Iran. This library aims to create a Solar Hijri date library that closely resembles Ruby's built-in date library, providing a seamless experience for users who need to work with the Solar Hijri dates. The conversion algorithm used in this library is adopted from [FarsiWeb](http://www.farsiweb.info/jalali/jalali.c).

## Features

- **Parsi::Date** and **Parsi::DateTime**: These objects can be used just like Ruby's `Date` and `DateTime` objects.
- **Date Conversion:** Easily convert between Gregorian and Solar Hijri dates.
- **Leap Year Calculation:** Determine if a given Solar Hijri year is a leap year.
- **Date Parsing and Formatting:** Parse Solar Hijri date strings and format dates in various styles.

## Usage

### Basic Operations

You can use `Parsi::Date` and `Parsi::DateTime` objects in the same way you use `Date` and `DateTime` objects in Ruby. Here are some examples:

```ruby
# Get today's Solar Hijri date
a = Parsi::Date.today
# => #<Parsi::Date: 1391-08-09 (4912461/2,0/1)>

# Add 12 months to it
b = a >> 12
# => #<Parsi::Date: 1392-08-09 (4913193/2,0/1)>

# Count the number of Sundays between two dates
a.upto(b).select{ |d| d.sunday? }.count
# => 52

# Check if a given year is a leap year
Parsi::Date.leap?(1391)
# => true
```

### Parsing and Formatting Dates

You can parse Solar Hijri date strings and format them in various styles:

```ruby
# Parse a Solar Hijri date string
c = Parsi::Date.parse("1391/10/12")
# => #<Parsi::Date: 1391-10-12 (4912587/2,0)>

# Format the date in Persian
c.strftime("%A %d %B %Y")
# => "سه‌شنبه 12 دی 1391"

# Format the date in English
c.strftime("%^EA %d %^EB %Y")
# => "Seshambe 12 Day 1391"
```

### Converting Between Calendars

You can easily convert between Gregorian and Solar Hijri dates:

```ruby
# Convert a Gregorian date to Solar Hijri
d = Date.civil(2012, 10, 30).to_parsi
# => #<Parsi::Date: 1391-08-09 (4912461/2,0/1)>

# Convert a Solar Hijri date back to Gregorian
d.to_gregorian
# => #<Date: 2012-10-30 ((2456231j,0s,0n),+0s,2299161j)>
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'parsi-date'
```

And then execute:

```sh
bundle install
```

Or install it yourself as:

```sh
gem install parsi-date
```

## License

The Parsi Date library is open-source software licensed under the MIT license.

## Contributing

If you would like to contribute to the development of the Parsi Date library, please feel free to fork the repository and submit pull requests. Contributions, bug reports, and feature requests are welcome and appreciated.
