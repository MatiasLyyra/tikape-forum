
class CategoriesController < ApplicationController
  before_action :set_category, only: [:show]
  before_action :list_all_categories, :list_all_sub_categories, only: [:index]

  def index
  end

  def new
  end

  def create
  end

  def show
    @discussions = Discussion.getDiscussionsByCategory(@category.id, params[:page])
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
end
