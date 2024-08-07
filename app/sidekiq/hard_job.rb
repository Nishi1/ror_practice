class HardJob
  include Sidekiq::Job
  sidekiq_options retry: 5

  def perform(*args)
    # Do something
    puts "Performing hard work with arguments: #{args.inspect}"
  end
end
