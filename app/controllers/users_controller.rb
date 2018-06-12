class UsersController < ApplicationController 
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
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
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, 
                                 :password_confirmation)
  end
end