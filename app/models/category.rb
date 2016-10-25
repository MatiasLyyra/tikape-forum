class Category < ApplicationRecord
  self.table_name = 'Category'

  validates :name, presence: true

  def self.createCategory(subject)
    Category.find_by_sql(["INSERT INTO Category (subject) VALUES (?)", subject.to_s])
  end

  def self.findCategory(subject)
    Category.find_by_sql(["SELECT * FROM Category WHERE subject=?", subject.to_s]).first
  end

  def self.getCategoryById(id)
    Category.find_by_sql(["SELECT * FROM Category WHERE id=?", id.to_i]).first
  end

  def getSubCategories
    Category.find_by_sql(["SELECT * FROM Category WHERE upper_category_id=?", self.id])
  end

end
