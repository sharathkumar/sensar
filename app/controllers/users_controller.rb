class UsersController < ApplicationController
  layout :false
	before_filter :require_user, :only => [:show, :edit, :update, :index]

  def new
    @user = User.new
  end

  def index
    @user = User.first
  end

  def create
    @user = User.new(user_params)
    # Saving without session maintenance to skip
    # auto-login which can't happen here because
    # the User has not yet been activated
    # if @user.save
    #   flash[:notice] = "Your account has been created."
    #   redirect_to signup_url
    # else
    #   flash[:notice] = "There was a problem creating you."
    #   render :action => :new
    # end

    respond_to do |format|
	    if @user.save
	      format.html { render json: @user }
	    	format.json { render json: @user }
	    else
	      format.html { render json: "@user" }
	    	format.json { render json: "@user" }
	    end
	  end

  end

  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user # makes our views "cleaner" and more consistent
    if @user.update_attributes(user_params)
      flash[:notice] = "Account updated!"
      redirect_to account_url
    else
      render :action => :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :login)
  end

end
