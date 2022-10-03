require 'pandoc-ruby'
require 'nokogiri'

PATH = ARGV[0]

def run
  Dir.glob("#{PATH}/*.md") do |entry|
    converted = File.basename(entry, ".md")
    File.open("#{PATH}/#{converted}.html", "w") { |f|
      f.write PandocRuby.new(File.read(entry), :standalone, from: 'markdown').to_html
    }
  end
end

run