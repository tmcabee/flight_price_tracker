class FlightInfo

  def self.create_from(data, title)
    info = new(data, title)
    info if info.desired?
  end

  def initialize(data, title)
    #["2016 7 22", "America/New_York", "460.35@K@ADT@KLAEV@34.55@8@0~0@22.6", "", "6:35", "3163", "ATL", "HOU", "5:55 AM", "6:55 AM", "0", "WN", "3163", "73W", "-", "2185", "HOU", "LAX", "8:10 AM", "9:30 AM", "0", "WN", "2185", "73W", "-"]
    @raw_data = data
    @date = data[0]
    @type = data[2]
    @number = data[5]
    @orig = data[6]
    @dest = data[7]
    @depart = data[8]
    @arrive = data[9]
    @number_of_stops = data[10]
    @price = title.value.split(' ')[3]
  end

  def desired?
    @raw_data.size < 20 and @type =~ /@[OMW]@/ and @number_of_stops == '0'
  end

  def to_s
    "#{date} #{@number} #{@orig} #{@dest} #{@depart} #{@arrive} #{@price}"
  end

  def date
    year, month, day = @date.split(' ')
    "#{month}/#{day}/#{year}"
  end
end
