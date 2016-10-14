class MessagesController < ApplicationController
  before_action :authenticate_user, only: [:create, :new]

  def index
  end

  def new
  end

  def create
    if Message.validate?(message_params[:message])
      @discussion = Discussion.getDiscussionById(params[:discussion_id])
      @category = Category.getCategoryById(params[:category_id])
      @message = Message.createMessage(@current_user.id,message_params[:message], params[:discussion_id]).first
      redirect_to category_discussion_path(@category, @discussion)
    else
      flash[:alert] = 'Invalid form'
      redirect_to :back
    end
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
