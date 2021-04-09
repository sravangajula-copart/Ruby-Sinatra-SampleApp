class CommentCreatorService
  include AppHelper

  def initialize(params)
    @params = params
    @errors = {}
    @response = {}
  end

  attr_reader :params, :errors, :response


  def validate
    # validation
    errors[:user] = "user doesn't exist" if user.blank?
    errors[:comment] = "Topic name should not be blank " if params[:comment_text].blank?
    errors[:invalid] = "Invalid reference type and Id" if invalid_references?
  end

  def user
    @user ||= User.find(user_id: params[:id], role_id: 3)
  end

  def invalid_references?
    case params[:reference_type].downcase
    when 'member'
      return true if member.blank?
    when 'topic'
      return true if topic.blank?
    end
  end

  def member
    @member ||= User.find(user_id: params[:reference_id], role_id: 2)
  end

  def topic
    @topic ||= Topic.find(topic_id: params[:reference_id])
  end

  def execute
    return response.merge!(errors: errors) if errors.present?

    response.merge(add_comment)
  end

  def add_comment
    Comment.create(comment_creator_paramms)
  end

  def comment_creator_paramms
    {
      comment_text: highlight_blacklisted_words,
      status: comment_status || 'A',
      crt_user_id: user.user_id,
      ref_id: params[:reference_id],
      ref_type: params[:reference_type].upcase
    }
  end

end