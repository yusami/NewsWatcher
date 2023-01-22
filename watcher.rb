#!/usr/bin/env ruby

require 'bundler'
Bundler.require
require 'open-uri'
require 'nokogiri'
require 'json'

def fetch(site)
  # Fetch url
  url = site[:url]
  opt = {}
  opt['User-Agent'] = 'Mozilla/5.0 (Windows NT 6.3; Win64, x64; Trident/7.0; rv:11.0) like Gecko'
  charset = nil
  html = URI.open(url,opt) do |f|
    charset = f.charset
    f.read
  end

  # Parse the HTML
  doc = Nokogiri::HTML.parse(html, nil, charset)
  puts "-----------"
  puts doc.title
  puts url

  # Show the items
  regex = site[:regex]
  doc.xpath(regex).each_with_index do |node, i|
    if node.inner_text then
        puts "- " + node.inner_text.strip
        break if i >= 9
    end
  end
end

if !File.exist?('config.json')
  puts 'The default config file is created since it does not exist.'
  File.open("config.json", 'w') do |file|
    # hash = [{"url" => "https://www.nikkei.com/", "regex" => '//div[@class="block_bummrov"]'}]
    hash = [{url: "https://www.nikkei.com/", regex: '//div[@class="block_bummrov"]'}]
    str = JSON.pretty_generate(hash)
    file.write(str)
  end
end

# URL and regex list
sites = []
File.open("config.json") do |file|
  puts "Reading the config file..."
  sites = JSON.load(file, nil, symbolize_names: true, create_additions: false)
end

sites.each do |site|
  fetch site
end

puts "-----------"
puts "Last updated: "+Time.now.iso8601
