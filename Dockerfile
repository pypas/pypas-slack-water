FROM ruby:3.1.0-slim

# install rails dependencies
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs libsqlite3-dev

ENV RAILS_ROOT /myapp
RUN mkdir -p $RAILS_ROOT
WORKDIR $RAILS_ROOT

# Copy the Gemfile and Gemfile.lock from app root directory into the /myapp/ folder in the docker container
COPY Gemfile ./
COPY Gemfile.lock ./

# Run bundle install to install gems inside the gemfile
RUN bundle install

RUN mkdir -p ./tmp/pids

# Script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

# Configure the main process to run when running the image
CMD ["rails", "server", "-b", "0.0.0.0"]
