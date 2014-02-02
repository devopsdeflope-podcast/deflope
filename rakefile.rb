# encoding: utf-8
require 'bluecloth'

desc "Generate habrahabr compatible html file. Use rake habr file=filename.md not for last file"
task :habr do
  if ENV['file']
    file = ENV['file']
  else
    file = Dir['source/posts/*.markdown'].sort.last
  end

  data = File.read(file)
  data = data.match(/\n---\n(.*)/m)[1]
  bc = BlueCloth.new data
  res = bc.to_html
  name = file.split('-').last.split('.').first
  url = "http://devopsdeflope.ru/posts/2014/#{name}.html"
  res = %Q[Ссылка на выпуск подкаста: <a href="#{url}">#{url}</a>\n\n] + res
  res.sub!(/<\/ul>/, "</ul>\n<habracut>\n")

  puts "Подкаст Девопс Дефлопе — выпуск " + name
  puts
  puts res
end
