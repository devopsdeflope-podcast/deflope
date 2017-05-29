# encoding: utf-8

module FeedHelpers
  def feed_data
    {
      :title => "DevOps Дефлопе подкаст",
      :description => "Русскоязычных подкаст, в котором мы рассказываем о DevOps движении и идеях, которые возникли и развиваются в рамках DevOps. Также мы рассказываем о инструментах DevOps инженеров: Docker, Kubernetes, Ansible, облаках, мониторинге, логировании, отказоустойчивости, катастрофоустойчивости, высоких нагрузках и много чем еще.",
      :author => "Никита Борзых и Константин Назаров",
      :owner => {:author => "Никита Борзых и Константин Назаров", :email => "input@devopsdeflope.ru"},
      :categories => {"Technology" => ["Podcasting", "Tech News"]},
      :image => "#{site_url}/images/deflope-itunes.jpg",
      :explicit => "no"
    }
  end

  def episode_data
    {
      :subtitle => "",
      :image => "#{site_url}/images/deflope-itunes.jpg",
      :keywords => "DevOps, Docker, Ansible, Kubernetes, AWS, Amazon, FAI"
    }
  end
end

