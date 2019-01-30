class Datum < ApplicationRecord
	AIR_SHIFT_URL = "https://connect.airregi.jp/login?client_id=SFT&redirect_uri=https%3A%2F%2Fconnect.airregi.jp%2Foauth%2Fauthorize%3Fclient_id%3DSFT%26redirect_uri%3Dhttps%253A%252F%252Fairshift.jp%252Fsft%252Fcallback%26response_type%3Dcode"
	
	def self.log_in_air_shift_and_get_data
	  	agent = Mechanize.new
		agent.user_agent_alias = 'Mac Safari 4'
		agent.get(AIR_SHIFT_URL) do |page|
		  	mypage = page.form_with(id: 'command') do |form|
		    	form.username = ENV["AIR_SHIFT_USERNAME"]
		    	form.password = ENV["AIR_SHIFT_PASSWORD"]
		  	end.submit
		  	air_shift_html_data = Nokogiri::HTML(mypage.content.toutf8)
			json_data = air_shift_html_data.xpath("//script")[3]["data-json"]
			hash_data = JSON.parse json_data
			return hash_data
		end
		return false
	end
	
end
