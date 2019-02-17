FROM ruby:2.6

WORKDIR '/app'
RUN apt-get update && apt-get install nodejs -y
COPY Gemfile Gemfile.lock /app/
RUN bundle install --path vendor/bundle

CMD ["/bin/bash"]
