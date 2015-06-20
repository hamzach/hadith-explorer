class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  #  respond_to do |format|
  #    format.html # new.html.erb
  #    format.json { render json: @user }
  #  end

  end

  # GET /users/1/edit
  #def edit
  #end

  def edit_profile
    id = session[:user_id].to_i
    user_id = params[:user_id].to_i 
    if session[:user_id] != nil && id.eql?(user_id)
      @user = User.find(user_id)
    else
      render text: "Some thing goes worng, Please try again later"
    end

  end

  # POST /users
  # POST /users.json

  # sign up
  def create
    @user = User.new(user_params)
    if session[:user_type] == "admin"
      @user.usertype = 'scholar'
    else
      @user.usertype = 'normal'  
    end
    respond_to do |format|
      if @user.save
        #format.html { redirect_to @user, notice: 'User was successfully created.' }
        if session[:user_type] == "admin"
          UserMailer.welcome_email(@user).deliver
          format.html { redirect_to adminView_url }
        else
          UserMailer.welcome_normal_email(@user).deliver
          format.html { redirect_to signuplogin_url(:id => @user.id) }
        end
        format.json { render action: 'show', status: :created, location: @user }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    id = params[:id]
    current_password = params[:currentpassword]
    user = User.authenticate_password(id, current_password)
    if user
      #respond_to do |format|
        if @user.update(user_params)
          #format.html { redirect_to @user, notice: 'User was successfully updated.' }
          #format.json { head :no_content }
          redirect_to :root
        else
          #format.html { render action: 'edit' }
          #format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      #end
    else
      render :action => "edit_profile"
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
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

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:firstname, :lastname, :email, :password, :verified)
    end
end
