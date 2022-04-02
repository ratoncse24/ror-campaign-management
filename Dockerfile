FROM ruby:2.7.2

ARG APP_ROOT=/campaign
RUN mkdir $APP_ROOT
WORKDIR $APP_ROOT

COPY Gemfile Gemfile.lock $APP_ROOT/

# install applications gems
RUN bundle install

# Copy application code
COPY . $APP_ROOT

# Expose the port to run the server
EXPOSE 3000

# change the access mode of entrypoint.sh
RUN chmod +x ./entrypoint.sh

# Set the entrypoint where the service start
ENTRYPOINT ./entrypoint.sh