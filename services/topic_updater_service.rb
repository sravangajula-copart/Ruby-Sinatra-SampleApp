class TopicUpdaterService
  def validate
    # validation
    errors[:member_not_exist] = "Member doesn't exist" if member.blank?
    errors[:topic_not_exist] = "Topic doesn't exist" if topic.blank?
  end

  def member
    @member ||= User.find(user_id: params[:member_id], role_id: 2)
  end

  def topic
    @topic ||= Topic.find(topic_id: params[:member_id], role_id: 2)
  end

  def execute
    return response.merge!(errors: errors) if errors.present?

    response.merge(topic.to_json)
  end

end