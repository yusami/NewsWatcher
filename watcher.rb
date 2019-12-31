#!/usr/bin/env ruby

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

  # Items
  regex = site[:regex]
  doc.xpath(regex).each_with_index do |node, i|
    puts "- " + node.elements.inject("",:+)
    break if i >= 9
  end
end

# URL list
sites = []
sites << {:url => "https://news.yahoo.co.jp/", :regex=>'//li[@class="topicsListItem "]'}
sites << {:url => "https://www.nikkei.com", :regex=>'//a[@class="k-card__block-link"]'}

sites.each do |site|
  fetch site
end
