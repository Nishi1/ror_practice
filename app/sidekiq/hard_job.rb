class HardJob
  include Sidekiq::Job

  def perform(*args)
    # Do something
    puts "Performing hard work with arguments: #{args.inspect}"
  end
end
