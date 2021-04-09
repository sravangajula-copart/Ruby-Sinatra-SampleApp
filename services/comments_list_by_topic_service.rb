class CommentsListByTopicService

  def initialize(params)
    @params = params
    @errors = {}
    @response = {}
  end

  attr_reader :params, :errors, :response

  def validate
    # validation
    errors[:user] = "User doesn't exist" if user.blank?
    errors[:user_not_admin] = "User is doesn't Admin" if !admin_user? && params[:role] == 'admin'
    errors[:user] = "User is not a external user " if !external_user? && params[:role] == 'user'
    errors[:topic_not_exist] = "Topic doesn't exist" if topic.blank?
  end

  def admin_user?
    user.role_id.to_i == 1
  end

  def external_user?
    user.role_id.to_i == 3
  end

  def user
    @user ||= User.find(user_id: params[:id])
  end

  def topic
    @topic ||= Topic.find(topic_id: params[:topic_id])
  end

  def execute
    return response.merge!(errors: errors) if errors.present?

    comments_info = case params[:filter_by]
                    when 'P'
                      topic.pending_comments
                    when 'A'
                      topic.approved_comments
                    else
                      topic.all_comments
                    end

    response.merge(data: decorate_data(comments_info))
  end

  def decorate_data(comments_info)
    comments_info.map(&:decorate)
  end

end
