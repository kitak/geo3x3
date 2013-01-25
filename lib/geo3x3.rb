require "geo3x3/version"

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
    self[0] == "E" 
  end

  def west_longitude?
    self[0] == "W" 
  end
end

module Geo3x3

  def self.encode(params)
    lat = params[:lat]
    lng = params[:lng]
    level = params[:level]

    code = 
      if lng.east_longitude?
        "E"
      else
        "W"
        lng = (180-lng)
      end

    lat = 90 - lat

    unit = 180 
    (level-1).times do |i|
      unit /= 3.0
      x = (lng/unit).floor
      y = (lat/unit).floor
      code += ((x + y*3) + 1).to_s

      lng -= x * unit
      lat -= y * unit
    end

    code
  end

  def self.decode(code)
    unit = 180
    lat = 0
    lng = 0
    level = 1

    code[1..-1].each_char do |c|
      break if c == "0"
      n = c.to_i

      unit /= 3.0
      n -= 1
      lng += (n % 3) * unit
      lat += (n / 3).floor * unit
      level += 1
    end

    lng -= 180 if code.west_longitude?
    lat = 90 - lat

    {
      lat:   lat,
      lng:   lng,
      level: level,
      unit:  unit
    }
  end
end
