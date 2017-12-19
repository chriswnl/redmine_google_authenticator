require_dependency 'user_patch'
require_dependency 'account_controller_patch'
require_dependency 'hooks'


Redmine::Plugin.register :google_authenticator do
  name 'Google Authenticator'
  author 'Chris Willis'
  description 'Adds Google Authenitcator 2-step authentication'
  version '0.0.2'

  settings default: {"two_step_auth" => {"by_user" => "disabled"} }, partial: 'settings/google_authenticator'
  #permission :view_ratings, :ratings => :index
  #menu(:top_menu, "Authentication", '/settings/authentication')
  User.send(:include, GoogleAuthenticator::UserPatch)
  AccountController.send(:include, GoogleAuthenticator::AccountControllerPatch)
  # Setting.plugin_google_authenticator["two_step_auth"]
end
