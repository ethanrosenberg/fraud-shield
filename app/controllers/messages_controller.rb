require 'uri'
  require 'net/http'

  require 'json'
require 'google/apis/safebrowsing_v4'

class MessagesController < ApplicationController

  #skip_before_filter :verify_authenticity_token
  #skip_before_filter :verify_authenticity_token
#skip_before_filter :authenticate_user!, :only => "reply"

def test


resp = check_google_safe_browsing("http://t.creovector.ru/downloader/www.citi.com/index.html")

byebug

end

def check_google_safe_browsing(url)

  begin

    request_body = {
    	"threatInfo": {
    		"threatTypes":      ["UNWANTED_SOFTWARE", "MALWARE", "SOCIAL_ENGINEERING"],
    		"platformTypes":    ["ANY_PLATFORM"],
    		"threatEntryTypes": ["URL"],
    		"threatEntries": [
    			{"url": url}
    		]
    	}
    }

    #"http://t.creovector.ru/downloader/www.citi.com/index.html"

    uri = URI.parse("https://safebrowsing.googleapis.com/v4/threatMatches:find?key=#{ENV["GOOGLE_API"]}")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Post.new(uri.request_uri)
    request.body = request_body.to_json
    request.add_field('Content-Type', 'application/json')
    # Send the request

    response = http.request(request).body

    data = JSON.parse(response)

    if data["matches"].size > 0
      return { analysis: "dangerous" }
    else
      return { analysis: "nothing found for this url." }
    end

  rescue
    return { analysis: "error." }

  end

end

 def reply
   message_body = params["Body"]
   from_number = params["From"]
   root_url = get_url_actual(message_body)
   boot_twilio
   sms = @client.messages.create(
     from: ENV["TWILIO_NUMBER"],
     to: from_number,
     #body: "Hello there, thanks for texting me. Your number is #{from_number}."
     body: "FRAUD SHIELD - \nActual domain location: #{root_url}\n\nMAKE SURE you recognize this url before clicking..."
   )

 end

 def get_url_actual(message_body)

#byebug
begin

    parsed_url = URI.extract(message_body, ['http', 'https'])[0]
    end_response = Net::HTTP.get_response(URI(parsed_url))
    root_url = Adomain.domain end_response['location']
    return root_url
rescue
    return "ERROR!"

end



   #Adomain.domain "http://t.creovector.ru/downloader/www.citi.com/index.html"

 end

 private

 def boot_twilio
   account_sid = ENV["TWILIO_ACCOUNT_SID"]
   auth_token = ENV["TWILIO_AUTH_TOKEN"]
   @client = Twilio::REST::Client.new account_sid, auth_token
 end

end
