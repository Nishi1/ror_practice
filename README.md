
# Sidekiq with Redis in a Rails Application

## Prerequisites

Ensure you have [Homebrew](https://brew.sh/) installed on your machine and a Rails application set up.

## Installing and Managing Redis

To install Redis, run:
```bash
brew install redis
```
Start the Redis server with:
```bash
redis-server
```
You can interact with Redis using the Redis CLI:
```
redis-cli
```

To list all keys in the Redis store, use:
```bash
KEYS *
```
To manage Redis as a service, stop it with:
```bash
brew services stop redis
```
And start it again with:
```bash
brew services start redis
```

Adding Sidekiq to Your Rails Application
Add the sidekiq gem to your Gemfile:
```bash
gem 'sidekiq'
```
Run bundle install to install the gem.

Add config file for sidekiq
```
:verbose: true
:timeout: 25
:queues:
  - critical
  - default
  - low
development:
  :concurrency: 5
```
Run sidekiq with following commands:
```
bundle exec sidekiq
bundle exec sidekiq -q critical # used to run critical queue only
bundle exec sidekiq -C config/sidekiq.yml # this will check the queue order in this file and process job as per the order mentioned.

```
Generate a Sidekiq job with:
```bash
rails generate sidekiq:job Hard
```

This creates a job file at app/jobs/hard_job.rb.

Configuring Sidekiq
To configure Sidekiq, first update your config/routes.rb file to mount the Sidekiq web interface:
```bash
require 'sidekiq/web'
mount Sidekiq::Web => '/sidekiq'
```

Next, create an initializer for Sidekiq at config/initializers/sidekiq.rb with the following content:
```bash
Sidekiq.configure_server do |config|
  config.redis = { url: ENV['REDIS_URL'] || 'redis://localhost:6379/0' }
end

Sidekiq.configure_client do |config|
  config.redis = { url: ENV['REDIS_URL'] || 'redis://localhost:6379/0' }
end
```
Scheduling a Job
To schedule a job, open the Rails console with:
```bash
rails console

HardJob.perform_async('some_arg', 1234)
```

Accessing the Sidekiq Web Interface
Navigate to

```bash
http://localhost:3000/sidekiq
```
in your browser to access the Sidekiq web interface.
