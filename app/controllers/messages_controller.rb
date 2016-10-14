class MessagesController < ApplicationsController
  before_action :authenticate_user, only: [:create, :new]

  def index
  end

  def new
  end
  
  def create
    if Message.validate?(message_params[:message])
      @message = Message.createMessage(message_params[:message], @current_user.id, :discussion_id).first
      redirect_to discussion_path(params[:discussion_id].to_i)
    else
      flash[:alert] = 'Invalid form'
      redirect_to :back
    end

  private
  def list_all_messages
    @message = Messages.find_by_sql(["SELECT * FROM Messages"])
  end

  def message_params
    # List of common params
    list_params_allowed = [:message]
    params.require(:message).permit(list_params_allowed)
  end
end

