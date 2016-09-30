class CategoriesController < ApplicationController
  before_action :set_category, only: [:show]

  def index
    @categories = Category.find_by_sql(["SELECT * FROM Category"])
  end

  def new
  end

  def create
  end

  def show
  end

  private

  def set_category
    @category = Category.getCategoryById(params[:id])
  end
end
