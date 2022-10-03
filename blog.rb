require 'pandoc-ruby'
require 'nokogiri'

PATH = ARGV[0]

def run
  Dir.glob("#{PATH}/*.md") do |entry|
    converted = File.basename(entry, ".md")
    File.open("#{PATH}/#{converted}.html", "w") do |f|
      f.write PandocRuby.new(File.read(entry), :standalone, "--shift-heading-level-by=-1", "--css #{Dir.pwd}/#{PATH}/style.css", from: 'markdown').to_html
    end
  end


end

run