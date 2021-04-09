class CommentUpdaterService
  include AppHelper

  def initialize(params)
    @params = params
    @errors = {}
    @response = {}
  end

  attr_reader :params, :errors, :response

  def validate
    # validation
    errors[:user_not_admin] = "User is doesn't Admin" if user.blank? || !admin_user?
    errors[:comment] = "Comment doesn't exist" if comment.blank?
  end

  def admin_user?
    user.role_id.to_i == 1
  end

  def user
    @user ||= User.find(user_id: params[:id])
  end

  def comment
    @comment ||= Comment.find(id: params[:comment_id])
  end

  def execute
    return response.merge!(errors: errors) if errors.present?

    response.merge(update_comment)
  end

  def update_comment
    comment.update(comment_updater_paramms)
  end

  # Admmin can update only comment text
  def comment_updater_paramms
    {
      comment_text: highlight_blacklisted_words,
      status: comment_status || 'A',
    }
  end
  
end