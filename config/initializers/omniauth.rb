Rails.application.config.middleware.use OmniAuth::Builder do

	provider :twitter, ENV['TWITTER_CONSUMER_KEY'], ENV['TWITTER_CONSUMER_SECRET']
  provider :linkedin, ENV['LINKEDIN_CLIENT_ID'], ENV['LINKEDIN_CLIENT_SECRET']
  provider :facebook, ENV['FACEBOOK_APP_ID'], ENV['FACEBOOK_SECRET'],
  	scope: 'public_profile', info_fields: 'id,name,link'
  provider :google_oauth2, ENV['GOOGLE_CLIENT_ID'], ENV['GOOGLE_CLIENT_SECRET'],
  scope: 'profile', image_aspect_ratio: 'square', image_size: 48, access_type: 'online'

end
OmniAuth.config.on_failure = Proc.new do |env|
	SessionsController.action(:auth_failure).call(env)
end
