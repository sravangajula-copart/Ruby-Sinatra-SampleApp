class DeleteTopicService
  
  def initialize(params)
    @params = params
    @errors = {}
    @response = {}
  end

  attr_reader :params, :errors, :response

  def validate
    # validation
    errors[:member_not_exist] = "Member doesn't exist" if invalid_user?
    errors[:topic_not_exist] = "Topic doesn't exist" if topic.blank?
    errors[:topic_error] = "Can't delete, Topic not created by member or Admin " if topic.present? && member.present? && invalid_member_or_admin?
  end

  def member
    @member ||= User.find(user_id: params[:member_id], role_id: 2)
  end

  def admin
    @admin ||= User.find(user_id: params[:member_id], role_id: 1)
  end

  def topic
    @topic ||= Topic.find(topic_id: params[:topic_id])
  end

  def invalid_user?
    member.blank? && admin.blank?
  end

  def invalid_member_or_admin?
    (topic.user_id != member.user_id ) || admin.present?
  end

  def execute
    return response.merge!(errors: errors) if errors.present?

    response.merge(delete_topic)
  end

  def delete_topic
    topic.destroy
    response.merge(success: true)
  end
end
