require 'user_patch'
require 'account_controller_patch'
require_dependency 'hooks'

Rails.configuration.to_prepare do
  User.send(:include, GoogleAuthenticator::UserPatch)
  AccountController.send(:include, GoogleAuthenticator::AccountControllerPatch)
  Setting.plugin_google_authenticator["two_step_auth"]
end

Redmine::Plugin.register :google_authenticator do
  name 'Google Authenticator'
  author 'Chris Willis'
  description 'Adds Google Authenitcator 2-step authentication'
  version '0.0.2'
  
  settings default: {two_step_auth: {} }, partial: 'settings/google_authenticator'
  #permission :view_ratings, :ratings => :index
  #menu(:top_menu, "Authentication", '/settings/authentication')
end

