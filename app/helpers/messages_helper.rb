module MessagesHelper
  def get_newest_message_date_in_discussion(discussion_id)
    newestMessage = Message.getMessagesByDiscussionId(discussion_id).first
    if newestMessage == nil
      return "No messages"
    end
    return newestMessage.time
  end

  def get_newest_message_date_in_category(category_id)
    newestMessage = Message.getNewestMessageByCategoryId(category_id)
    if newestMessage == nil
      return "No messages"
    end
    return newestMessage.time
  end

  def get_number_of_messages_in_category(category_id)
    Message.count_by_sql(["SELECT COUNT(*) FROM Message 
      INNER JOIN Discussion ON Message.discussion_id = Discussion.id
      INNER JOIN Category ON Discussion.category_id = Category.id
      WHERE category_id=?", category_id.to_i])
  end

  def get_number_of_messages_in_discussion(discussion_id)
    Message.count_by_sql(["SELECT COUNT(*) FROM Message 
      INNER JOIN Discussion ON Message.discussion_id = Discussion.id
      WHERE discussion_id=?", discussion_id.to_i])
  end
end
