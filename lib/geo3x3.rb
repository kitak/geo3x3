require File.expand_path("../geo3x3/version", __FILE__)

class Numeric 
  def east_longitude?
    self > 0
  end

  def west_longitude?
    # lng is negative value when west longitude 
    self < 0
  end

  def north_latitude?
    self > 0
  end

  def sourth_latitude?
    self < 0
  end
end

class String 
  def east_longitude?
    self[0] == "E" or self[0] == "+"
  end

  def west_longitude?
    self[0] == "W" or self[0] == "-"
  end
end

module Geo3x3

  def self.encode(params)
    lat = params[:lat].to_f
    lng = params[:lng].to_f
    level = params[:level]
    raise ArgumentError if level < 1

    code = 
      if lng.east_longitude?
        "E"
      else
        lng += 180
        "W"
      end

    lat = 90 - lat

    unit = 180.0 
    (level-1).times do
      unit /= 3
      x = (lng/unit).floor
      y = (lat/unit).floor
      code += ((x + y*3) + 1).to_s

      lng -= x * unit
      lat -= y * unit
    end

    code
  end

  def self.decode(code)
    code =
      case code
      when Integer
        code.west_longitude? ? "W#{code}" : "E#{code}"
      when String
        raise ArgumentError if code.empty?
        code
      else
        raise ArgumentError
      end

    unit = 180.0
    lat = 0.0
    lng = 0.0
    level = 1

    code[1..-1].each_char do |c|
      break if c == "0"
      n = c.to_i

      unit /= 3
      n -= 1
      lng += (n % 3) * unit
      lat += (n / 3) * unit
      level += 1
    end

    lat += unit / 2
    lng += unit / 2
    lat = 90 - lat
    lng -= 180 if code.west_longitude?

    {
      lat:   lat,
      lng:   lng,
      level: level,
      unit:  unit
    }
  end
end
