class SessionsController < ApplicationController
  def new
  	@user = User.new
  end



  def create
    email = params[:session][:email]
    password = params[:session][:password]

    user = User.authenticate_by_email(email, password)

    if user
    	session[:user_id] = user.id
      session[:user_type] = user.usertype
    	redirect_to :root
    else
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
