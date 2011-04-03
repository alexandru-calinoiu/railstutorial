class UsersController < ApplicationController
  before_filter :authenticate, :only => [:edit, :update, :index, :destroy]
  before_filter :correct_user, :only => [:edit, :update]
  before_filter :admin_user, :only => :destroy

  # GET /users
  # GET /users.xml
  def index
    @users = User.paginate(:page => params[:page], :per_page => 16)
    @title = "All users"

    respond_to do |format|
      format.html # index.html.erb
      format.xml { render :xml => @users }
    end
  end

  # GET /users/1
  # GET /users/1.xml
  def show
    @user = User.find(params[:id])
    @title = @user.name

    respond_to do |format|
      format.html # show.html.erb
      format.xml { render :xml => @user }
    end
  end

  # GET /users/new
  # GET /users/new.xml
  def new
    @user = User.new
    @title = "Sign up"
  end

  # GET /users/1/edit
  def edit
    @title = "Edit user"

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # POST /users
  # POST /users.xml
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        flash[:success] = "Welcome to the sample app!"
        sign_in(@user)
        format.html { redirect_to(@user, :notice => 'User was successfully created.') }
        format.xml { render :xml => @user, :status => :created, :location => @user }
      else
        @title = "Sign up"
        format.html { render :action => "new" }
        format.xml { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.xml
  def update
    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to(@user, :notice => 'User was successfully updated.') }
        format.xml { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    @user.destroy

    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml { head :ok }
    end
  end

  private

  def authenticate
    denny_access unless signed_in?
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to root_path unless current_user?(@user)
  end

  def admin_user
    @user = User.find(params[:id])

    if (current_user?(@user) && current_user.admin?)
      flash[:error] = "Can't delete admin user, who is going to be admin afterwards ?"
      redirect_to users_path
    else
      redirect_to(root_path) unless current_user.admin?
    end
  end
end
