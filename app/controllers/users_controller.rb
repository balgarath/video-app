class UsersController < ApplicationController

  before_filter :require_user, :only => [:show, :edit, :update]	
	
  # GET /users
  # GET /users.xml
  def index
    @users = User.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end

  # GET /users/1
  # GET /users/1.xml
  def show
    @user = @current_user
  end

  # GET /users/new
  # GET /users/new.xml
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    @user = @current_user
  end

  # POST /users
  # POST /users.xml
  def create
    @user = User.new(params[:user])

    if @user.save
      flash[:notice] = 'Account Registered!'
      redirect_back_or_default account_url
    else
      render :action => "new"
    end
  end

  # PUT /users/1
  # PUT /users/1.xml
  def update
    @user = @current_user
      if @user.update_attributes(params[:user])
        flash[:notice] = 'Account updated!'
        redirect_to account_url
      else
        render :action => "edit"
      end
  end

  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    redirect_to(users_url)
  end
  
end
