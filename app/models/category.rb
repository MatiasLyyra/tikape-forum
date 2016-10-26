class Category < ApplicationRecord
  self.table_name = 'Category'

  validates :subject, presence: true
  def self.validate?(*args)
    if args.second
      args.first.length > 3 && !Category.getCategoryById(args.second).nil?
    else
      args.first.length > 3
    end
  end

  def self.createCategory(subject)
    st = ActiveRecord::Base.connection.raw_connection.prepare("INSERT INTO Category (subject) VALUES (?)")
    st.execute(subject.to_s)
    st.close
    #Category.find_by_sql(["INSERT INTO Category (subject) VALUES (?)", subject.to_s])
  end

  def self.createSubCategory(subject, category_id)
    st = ActiveRecord::Base.connection.raw_connection.prepare("INSERT INTO Category (subject, upper_category_id) VALUES (?,?)")
    st.execute(subject.to_s, category_id.to_i)
    st.close
    #Category.find_by_sql(["INSERT INTO Category (subject) VALUES (?)", subject.to_s])
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
