# frozen_string_literal: true

require 'pandoc-ruby'
require 'date'
require 'rss'

PATH = ARGV[0]

def run
  Dir.glob("#{PATH}/*.md") do |entry|
    converted = File.basename(entry, '.md')
    File.open("#{PATH}/#{converted}.html", 'w') do |f|
      unless File.read(entry).include?("[Back](../#{PATH})")
        File.write(entry, "\n\n[Back](../#{PATH})", File.size(entry),
                   mode: 'a') 
      end
      f.write PandocRuby.new(File.read(entry), :standalone, '--css style.css',
                             from: 'markdown+pandoc_title_block').to_html
    end
  end

  toc
end

def toc
  files = []
  Dir.glob("#{PATH}/*.md") do |entry|
    date = Date.parse(IO.readlines(entry)[2][2..])
    files << [entry, date]
  end
  files = files.sort_by(&:last).reverse
  tocfile = File.open("./#{PATH}.md", 'w')
  tocfile.puts("% Blogposts\n\n")
  files.each do |file|
    tocfile.puts("#{file[1]} - [#{IO.readlines(file[0])[0][2..]
                 .strip!}](#{PATH}/#{File.basename(file[0], '.md')})\n\n")
  end
  tocfile.puts('[Back](./.)')
  tocfile.close

  File.open("./#{PATH}.html", 'w') do |f|
    f.write PandocRuby.new(File.read("./#{PATH}.md"), :standalone, "--css #{PATH}/style.css",
                           from: 'markdown+pandoc_title_block').to_html
  end
end

run
