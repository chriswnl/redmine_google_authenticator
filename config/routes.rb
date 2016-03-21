get "/login/verify" => "account#two_step", as: :two_step
put "/login/verify" => "account#check_two_step", as: :check_two_step
get "/dualauth/setup" => "two_step_auths#new", as: :new_two_step
patch "/dualauth/setup" => "two_step_auths#create", as: :create_two_step_auth
delete "/dualauth/disable" => "two_step_auths#destroy", as: :two_step_auth
get "/dualauth/qr" => "two_step_auths#show_qr_code", as: :show_qr_code

