class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper HTTPong::Rails::Helper
end
