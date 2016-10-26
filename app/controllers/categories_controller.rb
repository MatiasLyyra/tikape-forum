
class CategoriesController < ApplicationController
  before_action :authenticate_admin, only: [:create, :new, :new_subcategory]
  before_action :set_category, only: [:show]
  before_action :list_all_categories, :list_all_sub_categories, only: [:index, :show]

  def index
  end

  def new
  end

  def create
    if params[:category_id].present?
      if Category.validate?(params[:category][:subject], params[:category_id])
        Category.createSubCategory(params[:category][:subject], params[:category_id])
        category = Category.findCategory(params[:category][:subject])
        #Dirty hack below.
        redirect_to (category)
      else
        flash[:alert] = 'Invalid form'
        redirect_to :back
      end
    else
      if Category.validate?(params[:category][:subject])
        Category.createCategory(params[:category][:subject])
        category = Category.findCategory(params[:category][:subject])
        #Dirty hack below.
        redirect_to (category)
      else
        flash[:alert] = 'Invalid form'
        redirect_to :back
      end
    end
  end

  def new_subcategory
  end

  def show
    if @category.upper_category_id
      @parent_category = Category.getCategoryById(@category.upper_category_id)
    end
    @discussions = Discussion.getDiscussionsByCategory(@category.id, params[:page])
    #.sort_by{|discussion| Message.getMessagesByDiscussionId(discussion.id).map(&:last_edited)}
  end

  private

  def set_category
    @category = Category.getCategoryById(params[:id])
  end

  def list_all_categories
    @categories = Category.find_by_sql(["SELECT * FROM Category WHERE upper_category_id IS NULL"])
  end

  def list_all_sub_categories
    subCategories = Category.find_by_sql(["SELECT * FROM Category WHERE upper_category_id IS NOT NULL"])
    @allSubCategories = {}
    subCategories.each do |subCategory|
      @allSubCategories[subCategory.upper_category_id] ||= Array.new
      @allSubCategories[subCategory.upper_category_id].push(subCategory)
    end
  end

  def category_params
    # List of common params
    list_params_allowed = [:subject, :upper_category_id]
    params.require(:category).permit(list_params_allowed)
  end
end
