class GeocoordinatesService

  def get_coordinates(gear_items)
    gear_items.each do |gear_item|
      gear_item.lat = get_lat(gear_item[:location])
      gear_item.long = get_long(gear_item[:location])
    end
  end

  def get_location(location)
    conn = Faraday.get("https://maps.googleapis.com/maps/api/geocode/json") do |f|
      f.params['address'] = location
      f.params['key'] = ENV['MAPS_KEY']
    end
    json = JSON.parse(conn.body, symbolize_names: true)
    json[:results].first[:access_points].first[:location]
    require "pry"; binding.pry
  end

end
