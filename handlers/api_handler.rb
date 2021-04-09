class ApiHandler < Sinatra::Application
  before do
    content_type 'application/json'
  end

  get '/' do
    "Welcome to Blogs"
  end

  # Manage users

  # List all users in the system
  get '/users' do
    User.all.to_json
  end

  # show specific user
  get '/users/:user_id' do

  end

  # admin adding new members & user
  post '/admin/:id/users' do
    logger.info params.inspect
    request_service(CreateUsersService, params)
  end

  delete '/admin/:id/users/:user_id' do
    logger.info  params.inspect
    request_service(DeleteUserService, params)
  end

  #
  # Manage topics
  #

  # list of topics for all user
  get '/all_topics' do
    Topic.all.map(&:decorate).to_json
  end

  # list of topics by user
  get '/members/:member_id/topics' do
    logger.info params.inspect
    request_service(TopicsListByUserService, params)
  end

  # create topic
  post '/members/:member_id/topics' do
    logger.info params.inspect
    request_service(CreateTopicService, params)
  end

  # show specific topic
  get '/members/:member_id/topics/:topic_id' do
    logger.info  params.inspect
    request_service(TopicGetterService, params)
  end

  patch '/members/:member_id/topics/:topic_id' do
    # TODO -  Yet to implement
  end

  delete '/members/:member_id/topics/:topic_id' do
    logger.info params.inspect
    request_service(DeleteTopicService, params)
  end

  #
  # Manage comments
  #

  # Add comments to the Reference type  - TOPIC, MEMBER and respective and reference ids
  post '/users/:id/comments/:reference_type/:reference_id' do
    # comments should be scanned through the Profanity Filter
    logger.info params.inspect
    request_service(CommentCreatorService, params)
  end

  # admins can see all the pending comments
  get '/admin/:id/topics/:topic_id/pending_comments' do
    logger.info params.merge!(filter_by: 'P', role: 'admin')
    request_service(CommentsListByTopicService, params)
  end

  # admins can see all comments
  get '/admin/:id/topics/:topic_id/comments' do
    logger.info params.merge!(role: 'admin')
    request_service(CommentsListByTopicService, params)
  end

  # users can see only  Approved comments
  get '/users/:id/:topics/:topic_id/comments' do
    logger.info params.merge!(filter_by: 'A', role: 'user')
    request_service(CommentsListByTopicService, params)
  end

  # admin can approve / reject any comment for any topic
  patch '/admin/:id/comments/:comment_id' do
    logger.info  params.inspect
    request_service(CommentUpdaterService, params)
  end


  private

  def call_service(service_class, params)
    service = service_class.new(params)
    service.validate
    service.execute
  end

  def error_response(response)
    halt(400, { message: response[:errors]}.to_json)
  end

  def request_service(klass, params)
    service_response = call_service(klass, params)
    service_response[:errors].present? ? error_response(service_response) : service_response.to_json
  end

end