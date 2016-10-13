
class DiscussionsController < ApplicationController
  before_action :list_all_discussions, only: [:index]
  before_action :authenticate_user, only: [:new, :create]


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
    @discussion = Discussion.getDiscussionById(params[:id])
    
  end




  private



  def list_all_discussions
    @discussions = Discussion.find_by_sql(["SELECT * FROM Discussion"])
  end

  def discussion_params
    # List of common params
    list_params_allowed = [:title, :category_id]
    params.require(:discussion).permit(list_params_allowed)
  end
end
