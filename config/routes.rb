get "/login/verify", :to => "account#two_step", :as => :two_step
put "/login/verify", :to => "account#check_two_step", :as => :check_two_step
get "/dualauth/setup", :to => "two_step_auths#new", :as => :new_two_step
patch "/dualauth/setup", :to => "two_step_auths#create", :as => :create_two_step_auth
delete "/dualauth/disable", :to => "two_step_auths#destroy", :as => :two_step_auth
get "/dualauth/qr", :to => "two_step_auths#show_qr_code", :as => :show_qr_code

