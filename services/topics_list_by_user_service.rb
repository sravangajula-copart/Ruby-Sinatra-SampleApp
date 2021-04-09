class TopicsListByUserService
  def initialize(params)
    @params = params
    @errors = {}
    @response = {}
  end

  attr_reader :params, :errors, :response


  def validate
    # validation
    errors[:member_not_exist] = "Member doesn't exist" if member.blank?
  end

  def member
    @member ||= User.find(user_id: params[:member_id], role_id: 2)
  end

  def execute
    return response.merge!(errors: errors) if errors.present?

    response.merge(data: topics_list)
  end

  def topics_list
    member.topics.map(&:decorate)
  end

end