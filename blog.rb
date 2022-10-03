require 'pandoc-ruby'
require 'nokogiri'

PATH = ARGV[0]

def run
  Dir.glob("#{PATH}/*.md") do |entry|
    converted = File.basename(entry, ".md")
    File.open("#{PATH}/#{converted}.html", "w") do |f|
      File.write(entry, "\n\n[Back](./)", File.size(entry), mode:'a') unless File.read(entry).include?("[Back](./)")
      f.write PandocRuby.new(File.read(entry), :standalone, "--css #{Dir.pwd}/#{PATH}/style.css", from: 'markdown+pandoc_title_block').to_html
    end
  end


end

run