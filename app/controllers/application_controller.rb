class ApplicationController < ActionController::Base
  protect_from_forgery

  def authenticate!
    authenticate_or_request_with_http_basic do |login, password|
      login == 'masq' && password == 'secret'
    end
  end

  def authenticate_admin!
    authenticate_or_request_with_http_basic do |login, password|
      login == 'director' && password == 'secret'
    end
  end
end
