class TodosController < ApplicationController
  before_action :authenticate_user!
  before_action :set_todo, only: [:show, :edit, :update, :destroy, :toggle]

  def index
    @todos = current_user.todos
    @upcoming = @todos.upcoming
    @overdue = @todos.overdue
    @completed = @todos.completed
  end

  def show
  end

  def new
    @todo = current_user.todos.build
  end

  def create
    @todo = current_user.todos.build(todo_params)
    
    if @todo.save
      redirect_to todos_path, notice: 'Todo was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @todo.update(todo_params)
      redirect_to todos_path, notice: 'Todo was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @todo.destroy
    redirect_to todos_url, notice: 'Todo was successfully deleted.'
  end

  def toggle
    @todo.update(completed: !@todo.completed)
    redirect_to todos_path, notice: 'Todo status was updated.'
  end

  private

  def set_todo
    @todo = current_user.todos.find(params[:id])
  end

  def todo_params
    params.require(:todo).permit(:title, :description, :due_date)
  end
end
