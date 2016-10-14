class MessagesController < ApplicationController
  before_action :authenticate_user, only: [:create, :new]

  def index
  end

  def new
  end

  def create
    @discussion = Discussion.getDiscussionById(params[:discussion_id])
    if Message.validate?(params[:message], @discussion)
      @category = Category.getCategoryById(params[:category_id])
      @message = Message.createMessage(@current_user.id,params[:message], params[:discussion_id]).first
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
    params.require(:message).permit(:message)
  end
end
