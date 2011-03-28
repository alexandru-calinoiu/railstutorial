class SessionsController < ApplicationController
  def new
    @title = "Sign in"
  end

  def create
    user = User.authenticate(params[:session][:email], params[:session][:password])
    @title = "Sign in"

    if user.nil?
      flash.now[:error] = "Invalid email/password combination."

      respond_to do |format|
        format.html { render :action => "new" }
      end
    else
      sign_in(user)
      respond_to do |format|
        format.html { redirect_to user }
      end
    end
  end

  def destroy
    sign_out
    respond_to do |format|
      format.html { redirect_to root_path }
    end
  end

end
