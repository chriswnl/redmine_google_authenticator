module GoogleAuthenticator
  module UserPatch
    def self.included(base)
      base.extend(ClassMethods)
      base.send(:include, InstanceMethods)

      base.class_eval do
        unloadable

        has_one :two_step_auth, dependent: :destroy

        def self.authenticating=(user)
          RequestStore.store[:authenticating_user] = user
        end
        
        def self.authenticating
          u = RequestStore.store[:authenticating_user]
          User.find u
        end
        
        def gauth_tmp
          @guath_tmp ||= ROTP::TOTP.new(self.two_step_auth.secret)
        end



      end
    end
    
    module ClassMethods
    end
    
    module InstanceMethods
      def dual_auth?
        two_step_auth.try(:secret) && two_step_auth.enabled? && TwoStepAuth.is_enabled?  && !two_step_auth.exempted?
      end
    end
    
  end
end
