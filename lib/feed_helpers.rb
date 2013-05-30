# encoding: utf-8

module FeedHelpers
  def feed_data
    {
      :title => "Ruby NoName podcast",
      :description => "Серия русскоязычных подкастов о языке Ruby, фреймворке Rails и различных других техонологиях, с ними связанными, начиная от PostgreSQL и Redis, и заканчивая JavaScript. Каждый выпуск состоит из двух частей — короткий блок новостей в мире Ruby, и длинный блок, состоящий из обсуждений и интервью с различными участинками русскоязычного Ruby-сообщества",
      :author => "Иван Самсонов и Иван Евтухович",
      :owner => {:author => "Иван Самсонов и Иван Евтухович", :email => "evtuhovich@gmail.com"},
      :categories => {"Technology" => ["Podcasting", "Tech News"]},
      :image => "#{site_url}/images/rnp.png",
      :explicit => "no"
    }
  end

  def episode_data
    {
      :subtitle => "poscast.name = nil",
      :image => "#{site_url}/images/rnp.png",
      :keywords => "Ruby, NoName, RubyNoName, Rails"
    }
  end
end

