class CommandWorker
  include Sidekiq::Worker
  sidekig_options retry: false # job will be discarded immediately if failed

  def perform(params)
    Commands::Processor.init(params).run
  end
end