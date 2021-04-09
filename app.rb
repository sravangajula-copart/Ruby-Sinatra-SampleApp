
# myapp.rb
require 'active_support/all'
require 'logger'
require 'sinatra'
require 'sinatra/base'
require 'sinatra/reloader'
require 'sequel/model'
require 'pry'

require_relative 'config/constants.rb' # profanity words
require_relative 'config/init'
require_relative 'helpers/app_helper.rb'

require_relative 'handlers/api_handler.rb'
%w[user comment topic].each {|f| require_relative "models/#{f}.rb" }
require_relative 'services/create_users_service.rb'
require_relative 'services/delete_user_service.rb'
require_relative 'services/create_topic_service.rb'
require_relative 'services/delete_topic_service.rb'
require_relative 'services/topics_list_by_user_service.rb'
require_relative 'services/topic_getter_service'
require_relative 'services/topic_updater_service'
require_relative 'services/comment_creator_service.rb'
require_relative 'services/comment_updater_service.rb'
require_relative 'services/comments_list_by_topic_service.rb'


def logger
  @logger ||= ::Logger.new(STDOUT)
end

configure do
  logger.info "Registering reloader"
  register Sinatra::Reloader
end

