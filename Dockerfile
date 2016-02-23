FROM ruby:2.3.0
RUN mkdir -p /app
WORKDIR /app

COPY Gemfile* /app/
RUN bundle install

COPY . /app
EXPOSE 5000

CMD ["bundle", "exec", "unicorn", "-c", "/app/unicorn.rb"]
