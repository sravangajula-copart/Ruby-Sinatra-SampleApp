class CreateTopicService

  def initialize(params)
    @params = params
    @errors = {}
    @response = {}
  end

  attr_reader :params, :errors, :response


  def validate
    # validation
    errors[:member_not_exist] = "Member doesn't exist" if member.blank?
    errors[:topic_name] = "Topic name should not be blank " if params[:topic_name].blank? # current user is not an admin user
  end

  def member
    @member ||= User.find(user_id: params[:member_id], role_id: 2)
  end

  def execute
    return response.merge!(errors: errors) if errors.present?

    response.merge(add_topic)
  end

  def add_topic
    Topic.create(topic_name: params[:topic_name], topic_desc: params[:topic_description], user_id: params[:member_id])
  end
end
