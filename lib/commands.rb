# Get this from calling /weather 83864

 
# team_id=T0001
# team_domain=example
# channel_id=C2147483705
# channel_name=test
# user_id=U2147483697
# user_name=Steve
# command=/weather
# text=83864
# response_url=https://hooks.slack.com/commands/1234/5678

module Commands
  module Processor
    extend self

    # /command task:subtask message
    def init(params)
      command = command(params).titleize
      
      # Call Commands:TaskName(params)
      "Command::#{command}".constantize.new(params)
    end

    def command
      params[:command].scan(/\/(\w+)/).first.first
    end

    # Given `task:sub message`, return task
    def task(params)
      params[:text].scan(/\w+/).first
    end

    # Given `task:sub message`, return subtask
    def subtask(params)
      params[:text].scan(/\w+/)[1]
    end

    # Given `task:sub message`, return message
    def message(params)
      params[:text].scan(/\w+:\w+\s(.*)/, 1)
    end    
  end

  module Build
    def initialize(params)
      branch = branch(params)

      @api = CircleApi.new(ENV["ROCKY_CIRCLECI_API_TOKEN"])      
    end

    def run
      response = @api.trigger_new_build(branch)
    end

    # Extract branch name from message
    def branch(params)
      Processor.task(prams)
    end
  end
end