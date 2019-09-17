class TwoStepAuthsController < ApplicationController
  unloadable

  before_action :require_login
  
  #helper :issues
  helper :users
  #helper :custom_fields

  
  def new
    @user = User.current
    @two_step_auth = @user.create_two_step_auth
    
  end
  
  def show_qr_code
    @two_step_auth = User.current.two_step_auth
    send_data @two_step_auth.to_qr.to_s, :type => 'image/png',:disposition => 'inline'
  end
  
  def create
    @user = User.current
    @two_step_auth = @user.two_step_auth
    if @two_step_auth.get_ga.verify(params[:two_step_auth][:gauthcode])
      @two_step_auth.enable!
      redirect_to my_account_path, notice: "Dual factor authentication has been enabled."
    else
      flash[:alert] = "Could not verify you at this time. Check the time on your device and your computer are correct."
      render :new
    end
  end
  
  def destroy
    @user = User.current
    @user.two_step_auth.destroy
    redirect_to my_account_path, notice: "Dual factor authentication has been disabled. Feel free to set it up again."
  end
end
