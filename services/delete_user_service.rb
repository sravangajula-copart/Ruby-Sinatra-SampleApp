class DeleteUserService
  def initialize(params)
    @params = params
    @errors = {}
    @response = {}
  end

  attr_reader :params, :errors, :response


  def validate
    # validation
    errors[:user] = "User doesn't exist" if user.blank?
    errors[:admin_user] = "Current user is not a admin user" if admin_user.blank? # current user is not an admin user
    errors[:user_error] = "Cannot delete users. Please contact admin" if user_is_admin_user?
  end
  
  def user_is_admin_user?
    return admin_user.blank? || user.blank?
    admin_user.role_id.to_i == user.role_id.to_i
  end

  def admin_user
    @admin_user ||= User.find(user_id: params[:id], role_id: 1)
  end

  def user
    @user ||= User.find(user_id: params[:user_id])
  end

  def execute
    return response.merge!(errors: errors) if errors.present?

    response.merge(delete_user)
  end

  def delete_user
    user.destroy
    response.merge(success: true)
  end
end
