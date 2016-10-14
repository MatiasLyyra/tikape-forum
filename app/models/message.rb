class Message < ApplicationRecord
  self.table_name = 'message'

  validates :message, presence: true

  def self.validate?(*attr)
    attr.first.length > 0 && attr.second.valid?
  end

  def self.createMessage(user_id, message, discussion_id)
    time = Time.now.getutc.strftime('%Y-%m-%d %H:%M:%S')
    Message.find_by_sql(["INSERT INTO Message (user_id, message, time, last_edited, discussion_id) VALUES (?, ?, ?, ?, ?)", user_id.to_i, message.to_s, time, time, discussion_id.to_i])
  end

  #def self.findMessage(message) <--- finds by content (SORT BY..?)
    #Message.find_by_sql(["SELECT * FROM Message WHERE message LIKE...", message.to_s]).first
  #end

  def self.getMessagesByUser(message)
    Message.find_by_sql(["SELECT * FROM Message WHERE user_id=?", id.to_i])
  end

  def self.getMessagesByDiscussionId(discussion_id)
    Message.find_by_sql(["SELECT * FROM Message WHERE discussion_id=? ORDER BY time DESC", discussion_id.to_i])
  end

  def self.getMessageById(id)
    Message.find_by_sql(["SELECT * FROM Message WHERE id=?", id.to_i]).first
  end

  def self.getNewestMessageByCategoryId(category_id)
    Message.find_by_sql(["SELECT * FROM Message
      INNER JOIN Discussion ON Message.discussion_id = Discussion.id
      INNER JOIN Category ON Discussion.category_id = Category.id WHERE Category.id=?
      ORDER BY Message.time DESC LIMIT 1", category_id.to_i]).first
  end
  #def self.getMessageByUserInDiscussion(message)
	#Message.find_by_sql(["SELECT * FROM Message WHERE discussion_id=? AND user_id=?", discussion_id.to.i, user_id.to.i]).first
  #end
end
