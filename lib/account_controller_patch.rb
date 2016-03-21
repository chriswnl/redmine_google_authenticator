module GoogleAuthenticator
  module AccountControllerPatch
    extend ActiveSupport::Concern
    
    included do
      #after_action :do_something_else
    #end    
    
    def two_step
      #@user = User.authenticating
      @user = User.active.find(session[:authenticating_user])
      @two_step_auth = TwoStepAuth.new
    end    
    
    def check_two_step
      @two_step_auth = TwoStepAuth.new
      user = TwoStepAuth.verify! session[:authenticating_user], params[:two_step_auth][:gauthcode].strip
      if user.is_a? User
        
        session[:authenticating_user] = nil
        successful_authentication(user)
        update_sudo_timestamp! # activate Sudo Mode
      else
        redirect_to two_step_path, alert: "We couldn't validate you. Check the time"
      end 
    end
    
    
    private    
    
    def authenticate_user
      if Setting.openid? && using_open_id?
        open_id_authenticate(params[:openid_url])
      else
        #password_authentication
        two_step_auth
      end
    end
    
    def two_step_auth
      user = User.try_to_login(params[:username], params[:password], false)
      if user.nil?
        invalid_credentials
      elsif user.new_record?
        onthefly_creation_failed(user, {:login => user.login, :auth_source_id => user.auth_source_id })
      else
        # Valid user
        if user.active?
          if user.dual_auth? or TwoStepAuth.is_enforced?
            session[:authenticating_user] = user.id
            redirect_to two_step_path
          else
            successful_authentication(user)
            update_sudo_timestamp! # activate Sudo Mode
          end
        else
          handle_inactive_user(user)
        end
      end
    end
    
    end
    
  end # end of AccountControllerPatch
end