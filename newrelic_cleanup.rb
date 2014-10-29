require 'rubygems'
require 'json'
require 'unirest'

response = Unirest.post "https://api.newrelic.com/v2/servers.json",
			headers:{"X-Api-Key" => "xxxx"}


raw = JSON.parse(response.raw_body)
data = raw['servers']
data.each do |server|
	id = server['id']
	host = server['host']
	health = server['health_status']

	if health =~ /red/
		puts "#{host}: #{health}"
		system ("curl -X DELETE 'https://api.newrelic.com/v2/servers/#{id}.json' \
     -H 'X-Api-Key:xxxx' -i ")
	end
end
