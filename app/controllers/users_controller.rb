class UsersController < ApplicationController 
  #before_action :require_user, except: [:root]
  before_action :require_same_user, only: [:destroy]
  before_action :require_admin, only: [:destroy]
  
  def index
    @users = User.all
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash.now[:success] = "Profile has been created"
      redirect_to user_path(@user)
    else
      flash.now[:danger] = "Oops that didnt work! Lets try that again..."
      render 'new'
    end
    
  end
  
  def show
    @user =  User.find(params[:id])
  end
  
  def edit
    @user =  User.find(params[:id])
  end
  
  def update
    @user =  User.find(params[:id])
    if @user.update(user_params)
      flash.now[:success] = "Your Details have been updated"
    redirect_to user_path(@user)
    else
    render 'edit'
    end
  end
  
  def destroy
      @user =  User.find(params[:id])
      @user.destroy
      session[:user_id] = nil #New add here
      flash.now[:success] = "User was Deleted"
      redirect_to root_path
  end

  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, 
                                 :password_confirmation)
  end
  
  def require_same_user
    if current_user != @user and !current_user.admin?
      flash[:danger] = "You can only edit or delete your own account"
      redirect_to user_path
    end
  end
  
  def require_admin
    if logged_in? && !current_user.admin?
      flash[:danger] = "Only admin users can perform this action"
      redirect_to root_path
    end
  end
end