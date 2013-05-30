# encoding: utf-8

module FeedHelpers
  def feed_data
    {
      :title => "DevOps Дефлопе подкаст",
      :description => "Русскоязычных подкаст, в котором мы рассказываем о DevOps движении и идеях, которые возникли и развиваются в рамках DevOps. Также мы рассказываем о инструментах DevOps инженеров: Chef, Puppet, CFEngine, SaltStack, Cobbler, SpaceWalk, облаках, мониторинге, логировании, отказоустойчивости, катастрофоустойчивости, высоких нагрузках и много чем еще.",
      :author => "Никита Борзых и Иван Евтухович",
      :owner => {:author => "Никита Борзых и Иван Евтухович", :email => "evtuhovich@gmail.com"},
      :categories => {"Technology" => ["Podcasting", "Tech News"]},
      :image => "#{site_url}/images/deflope.png",
      :explicit => "no"
    }
  end

  def episode_data
    {
      :subtitle => "",
      :image => "#{site_url}/images/deflope.png",
      :keywords => "DevOps, Chef, Puppet, CFEngine, AWS, Amazon, Cobbler, FAI"
    }
  end
end

