class Discussion < ApplicationRecord
  self.table_name = 'discussion'

  validates :name, presence: true
  def self.validate?(title, category_id)
    title.length > 3 && (not Category.getCategoryById(category_id).nil?)
  end

  def self.createDiscussion(title, category_id)
    Discussion.find_by_sql(["INSERT INTO Discussion (title, category_id) VALUES (?, ?)", title.to_s, category_id.to_i])
  end

  def self.findDiscussionsByTitle(title)
    Discussion.find_by_sql(["SELECT * FROM Discussion WHERE title LIKE ?", title.to_s])
  end

  def self.getDiscussionById(id)
    Discussion.find_by_sql(["SELECT * FROM Discussion WHERE id=?", id.to_i]).first
  end

  def self.getDiscussionsByCategory(category_id)
    Discussion.find_by_sql(["SELECT * FROM Discussion WHERE category_id=?", category_id.to_i])
  end
end
