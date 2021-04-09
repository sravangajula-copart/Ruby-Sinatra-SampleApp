class CreateUsersService
  def initialize(params)
    @params = params
    @errors = {}
    @response = {}
  end

  attr_reader :params, :errors, :response


  def validate
    # validation
    errors[:user] = "Current user is not a admin user" if admin_user.blank? # current user is not an admin user
    errors[:user_exist] = "Cannot create multiple Admin users" if admin_user_exist?
  end
  
  def admin_user_exist?
    admin_user&.role_id.to_i == params[:role_id].to_i
  end

  def admin_user
    @admin_user ||= User.find(user_id: params[:id], role_id: 1)
  end

  def execute
    return response.merge!(errors: errors) if errors.present?

    response.merge(add_user)
  end

  def add_user
    User.create(first_name: params[:first_name], last_name: params[:last_name], role_id: params[:role_id])
  end
end
