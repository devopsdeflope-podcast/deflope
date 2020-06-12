# encoding: utf-8

module FeedHelpers
  def feed_data
    {
      :title => "DevOps Дефлопе подкаст",
      :description => "Русскоязычный подкаст, в котором мы рассказываем о DevOps движении и идеях, которые возникли и развиваются в рамках DevOps. Также мы рассказываем о инструментах DevOps инженеров: Docker, Kubernetes, Ansible, облаках, мониторинге, логировании, отказоустойчивости, катастрофоустойчивости, высоких нагрузках и много чем еще.",
      :author => "Андрей Александров и Виталик Хабаров",
      :owner => {:author => "Андрей Александров и Виталик Хабаров", :email => "input@devopsdeflope.ru"},
      :categories => {"Technology" => ["Podcasting", "Tech News"]},
      :image => "#{site_url}/images/deflope-itunes.jpg",
      :explicit => "no",
      :keywords => "124640"
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

