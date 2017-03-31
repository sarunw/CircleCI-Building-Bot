class CommandsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    # return render json: {}, status: 403 unless valid_slack_token?

    CommandWorker.perform_async(command_params.to_h)
    render json: { 
      response_type: "in_channel",
      text: "Done"
    }
  end

  private

    def valid_slack_token?
      params[:token] == ENV["SLACK_SLASH_COMMAND_TOKEN"]
    end

    def command_params
      params.permit(:text, :token, :response_url, :user_id)
    end
end
