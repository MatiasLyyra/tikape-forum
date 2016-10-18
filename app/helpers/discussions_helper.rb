module DiscussionsHelper
  def get_number_of_discussions_in_category(category_id)
    Discussion.count_by_sql(["SELECT COUNT(*) FROM Discussion WHERE category_id = ?", category_id.to_i])
  end
end