module Mindbody
  class Base
    def initialize api_key, site_id, user_token
      @base_url = 'https://api.mindbodyonline.com/public/v6'
      # @user = User.find_by(slug: user_slug)
      @headers  = { 
        'Content-Type': 'application/json',
        'Api-Key': api_key,
        'SiteId': site_id,
        'Authorization': user_token
      }
      @request_pool = Typhoeus::Hydra.hydra
    end

    def parse(response_body)
      JSON.parse(response_body, symbolize_names: true)
    end

    def update_user_token_last_used(response_code)
      if @user.token && response_code == 200
        p "[DEBUG] Response code for call is #{response_code}"
        @user.update_attribute(:token_last_used_at, Time.zone.now)
      end
    end
  end
end