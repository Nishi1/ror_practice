class SoftJob
  include Sidekiq::Job

  def perform(*args)
    puts "Default Performing hard work with arguments: #{args.inspect}"
  end
end
