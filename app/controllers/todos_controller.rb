class TodosController < ApplicationController
  before_action :set_todo, only: [:show, :edit, :update, :destroy]
  before_action :require_user, except: [:index, :show]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  
  def index
    @todos = Todo.all
  end
  
  def new
    @todo = Todo.new
    #@todo = Todo.paginate(page: params[:page], per_page: 5)
  end
  
  def create
    @todo = Todo.new(todo_params)
    @todo.user = current_user
    #@todo.user = User.first
    if @todo.save
      flash.now[:success] = "Todo was successfully created"
      redirect_to todo_path(@todo)
    else
      flash.now[:danger] ="Nope... Try it again"
      render 'new'
    end
  end
  
  def show
    
  end
  
  def edit
    
  end
  
  def update
    if @todo.update(todo_params)
      flash.now[:success] = "Todo was successfully Updated"
      redirect_to todo_path(@todo)
    else
      flash.now[:danger] = "That didn't work well! try again..."
      render 'edit'
    end
  end
  
  
  def destroy
     @todo.destroy
     flash.now[:success] = "Todo was deleted Successfully"
     redirect_to todos_path
  end
  
  private
  
  def set_todo
    @todo = Todo.find(params[:id])
  end
  
  def todo_params
    params.require(:todo).permit(:name, :description)
  end
  
  def require_same_user
    if current_user != @todo.user and !current_user.admin?
      flash[:danger] = "You can only edit or delete your own Todos"
      redirect_to todos_path
    end
  end
  
end