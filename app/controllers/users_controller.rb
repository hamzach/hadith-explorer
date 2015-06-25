class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all
  end

  
  def show
  end

  def new
    @user = User.new
  end

  def edit_profile
    id = session[:user_id].to_i
    user_id = params[:user_id].to_i 
    if session[:user_id] != nil && id.eql?(user_id)
      @user = User.find(user_id)
    else
      render text: "Some thing goes worng, Please try again later"
    end

  end
  def create
    @user = User.new(user_params)
    if session[:user_type] == "admin"
      @user.usertype = 'scholar'
    else
      @user.usertype = 'normal'
    end
    respond_to do |format|
      if @user.save
        if session[:user_type] == "admin"
          UserMailer.welcome_email(@user).deliver
          format.html { redirect_to adminView_url }
        else
          UserMailer.welcome_normal_email(@user).deliver
          format.html { redirect_to signuplogin_url(:id => @user.id) }
        end
        format.json { render action: 'show', status: :created, location: @user }
      else
        @errors = "Email alredy exists / Some fields are empty / Password mismatch"
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    id = params[:id]
    current_password = params[:currentpassword]
    user = User.authenticate_password(id, current_password)
    if user
        if @user.update(user_params)
          redirect_to :root
        else
        end
      #end
    else
      render :action => "edit_profile"
    end
  end

  def destroy
    if session[:user_id] && session[:user_type] == "admin"
      @user.destroy
      respond_to do |format|
        format.html { redirect_to adminView_url }
        format.json { head :no_content }
      end
    else
      render text: "Some thing goes worng, Please try again later"
    end
  end

  def messaging
    if session[:user_type] == "scholar"
    else
      render text: "error"
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:firstname, :lastname, :email, :password, :verified)
    end
end
