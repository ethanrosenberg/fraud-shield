require 'uri'
  require 'net/http'
require 'open-uri'

  require 'json'
  require 'google/cloud/vision'
  require "google/cloud/storage"

class MessagesController < ApplicationController

  #skip_before_filter :verify_authenticity_token
  #skip_before_filter :verify_authenticity_token
#skip_before_filter :authenticate_user!, :only => "reply"

def test


url = Url.create(address: "apple.com")
downloaded_image = open(url)
url.image.attach(io: downloaded_image)







  storage = Google::Cloud::Storage.new(
    project_id: "graphite-earth-246401",
    credentials: "./My First Project-62e5d12f8294.json"
  )

  bucket = storage.bucket "graphite-earth-246401-vcm"
  bucket.create_file "https://api.url2png.com/v6/P4DF2F8BC83648/e76d7eb625bf3ab27838a97630375e27/png/?thumbnail_max_width=851&url=https%3A%2F%2Fweb-kahuna.com%2Fw%2Fonline-banking%2FHA7UqdZhLZzZE6KHPTsWeWFM4HA7UqdZhLZzZE6KHPTsWeWFM4KksUW5UWWLhgqzwa4pdUHnYJYCSM9Z67ykLpkNyBcKksUW5UWWLhgqzwa4pdUHnYJYCSM9Z67ykLpkNyBc%2Fl%2Fwells_fargo%2Flogin&viewport=1280x2000"

byebug
  file = bucket.file "path/to/my-file.ext"

  # Download the file to the local file system
  file.download "/tasks/attachments/#{file.name}"

  # Copy the file to a backup bucket
  backup = storage.bucket "task-attachment-backups"
  file.copy backup, file.name


  answer = get_image_property_name("https://api.url2png.com/v6/P4DF2F8BC83648/e76d7eb625bf3ab27838a97630375e27/png/?thumbnail_max_width=851&url=https%3A%2F%2Fweb-kahuna.com%2Fw%2Fonline-banking%2FHA7UqdZhLZzZE6KHPTsWeWFM4HA7UqdZhLZzZE6KHPTsWeWFM4KksUW5UWWLhgqzwa4pdUHnYJYCSM9Z67ykLpkNyBcKksUW5UWWLhgqzwa4pdUHnYJYCSM9Z67ykLpkNyBc%2Fl%2Fwells_fargo%2Flogin&viewport=1280x2000")

  byebug
#image_annotator = Google::Cloud::Vision::ImageAnnotator.new version: :v1 project: ENV['GOOGLE_CLOUD_PROJECT'], keyfile: ENV['GOOGLE_CLOUD_KEYFILE_JSON']




  byebug

  #ision = Google::Cloud::Vision::rail.new
  image_uri = "gs://graphite-earth-246401-vcm/http-::bankofamerica.exileconsultant.com:BOA3:logindotphp.png"

  byebug

#resp = check_google_safe_browsing("http://t.creovector.ru/downloader/www.citi.com/index.html")



end

def get_image_property_name(url)

  image_annotator = Google::Cloud::Vision::ImageAnnotator.new

  response = image_annotator.document_text_detection(
    image: url,
    #max_results: 15 # optional, defaults to 10
  )

  #byebug

  text = []
  response.responses.each do |res|
    res.text_annotations.each do |annotation|
      content = annotation.description.gsub(/\R+/, ' ')
      text << content
    end
  end

  value = text.join(" ").downcase


  ['bank of america','wells fargo','paypal'].each do |flag|
    if value.include?(flag)
      return {
        flag: flag
      }
    end
  end

  return {
    flag: "none"
  }

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
   status = check_google_safe_browsing(parse_url_from_text(message_body))
   boot_twilio
   if status[:analysis] === "dangerous"
   content = "FRAUD SHIELD - \nWARNING!!\nActual domain location: #{root_url}\n\nThis url has been flagged as malicious."
   else
   content = "FRAUD SHIELD - \nActual domain location: #{root_url}\n\nMAKE SURE you recognize this url before clicking..."
   end

   sms = @client.messages.create(
     from: ENV["TWILIO_NUMBER"],
     to: from_number,
     media_url: ['https://c1.staticflickr.com/3/2899/14341091933_1e92e62d12_b.jpg'],
     #body: "Hello there, thanks for texting me. Your number is #{from_number}."
     body: content
   )

 end

 def parse_url_from_text(text)
  return URI.extract(text, ['http', 'https'])[0]
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
