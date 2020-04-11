#!/usr/bin/env ruby

require 'bundler'
Bundler.require
require 'open-uri'
require 'nokogiri'

def fetch(site)
  # Fetch url
  url = site[:url]
  opt = {}
  opt['User-Agent'] = 'Mozilla/5.0 (Windows NT 6.3; Win64, x64; Trident/7.0; rv:11.0) like Gecko'
  charset = nil
  html = open(url,opt) do |f|
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
        puts "- " + node.inner_text
        break if i >= 9
    end
  end
end

# URL and regex list
sites = []
sites << {:url => "https://news.yahoo.co.jp/", :regex=>'//li[@class="topicsListItem "]'}
sites << {:url => "https://www.nikkei.com/", :regex=>'//a[@class="k-card__block-link"]'}
sites << {:url => "https://www.kobe-np.co.jp/news/sanda/index.shtml", :regex=>"//div[@class='midashi']"}
sites << {:url => "https://www.kobe-np.co.jp/news/himeji/index.shtml", :regex=>"//div[@class='midashi']"}

sites.each do |site|
  fetch site
end

puts "-----------"
puts "Last updated: "+Time.now.iso8601
