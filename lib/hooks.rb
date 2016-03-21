module GoogleAuthenticator
  class Hooks < Redmine::Hook::ViewListener
    render_on :view_my_account_preferences, partial: "hooks/view_my_account_preferences"
  end
end