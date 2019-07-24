require 'uri'
require 'net/http'
require 'open-uri'
require 'openssl'
require 'json'
require 'google/cloud/vision'
require "google/cloud/storage"
require 'webshot'
require 'screencap'
require 'httparty'
require 'nokogiri'
require 'down'

class SearchUrlController < ApplicationController



  def search

    url = Url.create(address: params[:query])
    downloaded_image = open("https://api.urlbox.io/v1/5bZ0WiDHoxJXzZIT/png?url=#{encodeURIComponent(params[:query])}&full_page=true&block_ads=true")
    url.image.attach(io: downloaded_image, filename: "#{generate_activation_code(10)}-screenshot.png")
    google_storage_url = url.image.attachment.service_url
    url.save

  serv_url = google_storage_url.split('?')[0]


  # dom = Adomain.domain serv_url

        image_annotator = Google::Cloud::Vision::ImageAnnotator.new

        response = image_annotator.document_text_detection(
          image: serv_url.gsub("https://storage.googleapis.com", 'gs:/'),
          #max_results: 15 # optional, defaults to 10
        )

        text = []
        response.responses.each do |res|
          res.text_annotations.each do |annotation|
            content = annotation.description.gsub(/\R+/, ' ')
            text << content
          end
        end

        value = text.join(" ").downcase

        byebug

        item = ''

        ['bank of america','wells fargo','paypal'].each do |flag|
          if value.include?(flag)
            item = flag
            break

          end
        end


        if item != ''
          render json: { flag: item }
        else
          render json: { flag: "None Found" }
        end



  end

  def encodeURIComponent(val)
    URI.escape(val, Regexp.new("[^#{URI::PATTERN::UNRESERVED}]"))
  end

  def generate_activation_code(size = 6)
    charset = %w{ 2 3 4 6 7 9 A C D E F G H J K M N P Q R T V W X Y Z}
    (0...size).map{ charset.to_a[rand(charset.size)] }.join
  end


end

class NordProxy
  include HTTParty
  http_proxy 'us3272.nordvpn.com', 80, ENV["NORD_USERNAME"], ENV["NORD_PASSWORD"]
end
