
class HardJob
  include Sidekiq::Job
  sidekiq_options queue: 'critical'
  sidekiq_options retry: 5

  def perform(*args)
    puts "Performing hard work with arguments: #{args.inspect}"
  end
end
