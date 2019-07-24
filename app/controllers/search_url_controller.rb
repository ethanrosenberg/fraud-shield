require 'uri'
require 'net/http'
require 'open-uri'
require 'json'
require 'google/cloud/vision'
require "google/cloud/storage"

class SearchUrlController < ApplicationController
  def search

byebug

    url = Url.create(address: "apple.com")
    downloaded_image = open(url)
    url.image.attach(io: downloaded_image)


  end
end
