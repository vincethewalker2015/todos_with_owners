class UsersController < ApplicationController 
  before_action :require_same_user, only: [:edit, :update, :destroy]
  
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
      flash[:success] = "Profile has been created"
      redirect_to user_path(@user)
    else
      flash.now[:danger] = "Oopd that didnt work! Lets try that again..."
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
      flash[:success] = "Your Details have been updated"
    redirect_to user_path(@user)
    else
    render 'edit'
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, 
                                 :password_confirmation)
  end
  
  def require_same_user
    if current_user != @user
      flash[:danger] = "You can only edit or delete your own chef account"
      redirect_to users_path
    end
  end
end