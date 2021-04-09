class TopicGetterService
  def initialize(params)
    @params = params
    @errors = {}
    @response = {}
  end

  attr_reader :params, :errors, :response

  def validate
    # validation
    errors[:member_not_exist] = "Member doesn't exist" if member.blank?
    errors[:topic_not_exist] = "Topic doesn't exist for given member" if topic.blank?
  end

  def member
    @member ||= User.find(user_id: params[:member_id], role_id: 2)
  end

  def topic
    @topic ||= member.topics.detect{|t| t if t.topic_id == params[:topic_id].to_i }
  end

  def execute
    return response.merge!(errors: errors) if errors.present?

    response.merge(decorate)
  end

  def decorate
    {
      topic_id: topic.topic_id,
      topic_name: topic.topic_name,
      comments: topic.approved_comments.map(&:decorate)
    }
  end
end