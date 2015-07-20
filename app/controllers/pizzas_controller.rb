class PizzasController < ApplicationController
	def create
		update = User.where(id: current_user['id']).update_all(lat: params['lat'],lng: params['lng'])
	end
	def index
		if current_user
			#get ip address of request
			ip_url = "http://freegeoip.net/json/"
			# look up ip
	    # parse response
	    user = User.find(current_user['id'])
			client_id = "#{ENV['FOURSQUARE_CLIENT_ID']}"
			client_secret = "#{ENV['FOURSQUARE_CLIENT_SECRET']}"
			@lat = user["lat"]
			@lng = user["lng"]
			foursquare_url = "https://api.foursquare.com/v2/venues/explore?client_id=#{client_id}&client_secret=#{client_secret}&v=20130815&ll=#{@lat},#{@lng}&query=one+dollar+pizza&limit=10&radius=1610"
			venues_response =  HTTParty.get(foursquare_url)
			venues_info = JSON.parse(venues_response.response.body)
			path = JsonPath.new('$..venue')
			@venues = path.on(venues_info)
			# and make 4square request
		else 
			redirect_to root_path
		end
	end
end