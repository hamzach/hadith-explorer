class SessionsController < ApplicationController
  def new
  	@user = User.new
  end
  
  def create
    err = "Your login credentials are not correct"
    email = params[:session][:email]
    password = params[:session][:password]

    user = User.authenticate_by_email(email, password)

    if !user.nil? && user != err
    	session[:user_id] = user.id
      session[:user_type] = user.usertype
    	redirect_to :root
    else
      if user == err
        @errors = "Your login credentials are not correct"
      elsif user.nil?
        @errors = "Fill all fields"
      end
    	render :action => "new"
    end

  end

  def create1
    session[:user_id] = params[:id]
    session[:user_type] = params[:usertype]
    redirect_to :root
  end



  def destroy
    session[:user_id] = nil
    session[:user_type] = nil
    session[:target_id] = nil
    redirect_to :root
  end

  def signed_out
  end
end
