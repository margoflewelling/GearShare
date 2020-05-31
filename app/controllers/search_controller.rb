class SearchController<ApplicationController

  def new
  end

  def index
    @gear_items = GearItem.find_matches(query_params)
    #I think this is where we'll want to make the call to our microservice, using @gear_items and location_params
    distance = DistanceMatrixService.new
    close_gear = distance.filter_distance(@gear_items, location_params[:location], location_params[:distance])
    ## send to geocoordinates api to get lat/long
    geocoordinates = GeocoordinatesService.new
    item_locations = geocoordinates.get_coordinates(close_gear)
  end

  private

  def query_params
    params.permit(:keyword)
  end

  def location_params
    params.permit(:location, :distance)
  end

end
