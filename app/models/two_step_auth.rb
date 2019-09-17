class TwoStepAuth < ActiveRecord::Base

  unloadable
  
  belongs_to :user
  before_create :set_secret
  
  attr_reader :gauth_tmp
  attr_accessor :gauthcode
  
  def get_ga
    @get_ga ||= ROTP::TOTP.new(self.secret, issuer: Setting.app_title)
  end

  def get_qr
    self.secret
  end
  
  def self.verify!(userid,code)
    #get_ga.verify(code)
    user = User.active.find userid
    if user
      if user.two_step_auth.get_ga.verify(code)
        return user
      end
      return false
    end
  end
          
  def self.settings
    Setting.plugin_redmine_google_authenticator[:two_step_auth]
  end  
 
  def enable!
    self.update_attributes(enabled: true)
  end
  
  def self.is_enabled?
    true if self.settings["by_user"] == "enabled" or self.settings["force"] == "enabled" or self.settings["exempt_admins"] == "enabled"
  end
  
  def self.is_enforced?
    true if self.settings["force"] == "enabled"
  end
  
  def self.admins_exempt?
    true if self.settings["exempt_admins"] == "enabled"
  end
  
  def self.exempted?
    true if self.admins_exempt? && self.user.admin?
  end

  def gauth_tmp
    @gauth_tmp ||= set_gauth_tmp
  end

  def set_gauth_tmp
    self.instance_variable_set(:@gauth_tmp, ROTP::Base32.random_base32)
    self.gauth_tmp
  end
  
  def to_qr
    totp = ROTP::TOTP.new(self.secret, issuer: Setting.app_title)
    qrcode = RQRCode::QRCode.new(totp.provisioning_uri(self.user.login))
    tmpfile = "img-#{ROTP::Base32.random_base32(32)}.png"
    png = qrcode.as_png(
          resize_gte_to: false,
          resize_exactly_to: false,
          fill: 'white',
          color: 'black',
          size: 240,
          border_modules: 4,
          module_px_size: 6,
          file:  nil # path to write
          )
   
    
  end

  def set_secret
    self.secret = ROTP::Base32.random_base32
  end
  
end
