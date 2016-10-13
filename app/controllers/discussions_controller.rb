
class DiscussionsController < ApplicationController
  before_action :list_all_discussions, only: [:index]
  before_action :authenticate_user, only: [:new, :create]
  before_action :set_discussion, only: [:show]


  def index
  end

  def new
  end

  def create
    if Discussion.validate?(discussion_params[:title], params[:category_id])
      @discussion = Discussion.createDiscussion(discussion_params[:title], params[:category_id]).first
      redirect_to category_path(params[:category_id].to_i)
    else
      flash[:alert] = 'Invalid form'
      redirect_to :back
    end
  end

  def show
    @messages = Message.getMessagesByDiscussionId(@discussion.id)
    @firstMessage = @messages.shift
  end

  private
  def set_discussion
    @discussion = Discussion.getDiscussionById(params[:id])
  end

  def list_all_discussions
    @discussions = Discussion.find_by_sql(["SELECT * FROM Discussion"])
  end

  def discussion_params
    # List of common params
    list_params_allowed = [:title, :category_id, :message]
    params.require(:discussion).permit(list_params_allowed)
  end
end
