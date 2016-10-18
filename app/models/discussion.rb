class Discussion < ApplicationRecord
  self.table_name = 'discussion'

  validates :title, presence: true
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

  def self.getDiscussionsByCategory(category_id, page=nil)
    offset = (page.to_i-1) * 10
    Discussion.find_by_sql(["SELECT * FROM Discussion
      JOIN (SELECT discussion_id, MAX(time) AS MostRecent
      FROM Message
      GROUP BY discussion_id) AS M ON Discussion.id = M.discussion_id
      WHERE category_id=?
      ORDER BY M.MostRecent DESC
      LIMIT 10 OFFSET ?", category_id.to_i, offset])
  end
end
