class Api::V1::TodosController < ApplicationController
  before_action :authenticate_user!
  before_action :set_todo_and_authorize_ownership, only: [ :complete, :show, :update, :destroy ]

  def index
    todos = Todo.where(user: current_user)

    filters = {}
    filters[:completed] = params[:completed] if params[:completed].present?
    filters[:date] = params[:start_date]..params[:end_date] if params[:start_date].present? && params[:end_date].present?

    todos = todos.where(filters) if filters.any?

    render json: TodoSerializer.new(todos).serializable_hash[:data].map { |hash| hash[:attributes] }
  end

  def show
    render json: serialize(@todo)
  end

  def create
    task = Todo.create todo_params
    task.user = current_user
    if task.save
      render json: serialize(task), status: :created
    else
      render json: task.errors, status: :unprocessable_content
    end
  end

  def update
    if @todo.update! todo_params
      render json: serialize(@todo), status: :ok
    else
      render json: @todo.errors, status: :unprocessable_content
    end
  end

  def complete
    raise ArgumentError.new "Task is already completed" if @todo.completed
    @todo.complete
    if @todo.save
      render status: :ok
    else
      render json: task.errors, status: :unprocessable_content
    end
  end

  def destroy
    @todo.destroy
    head :no_content
  end

  private

  def serialize(todo)
    TodoSerializer.new(todo).serializable_hash[:data][:attributes]
  end

  def todo_params
    params.permit(:title, :description, :date, :important)
  end

  def set_todo_and_authorize_ownership
    @todo = Todo.find params[:id]
    unless @todo.user == current_user
      render json: { error: "Not enough permissions to perform this operation" }, status: :forbidden
    end
  end
end
