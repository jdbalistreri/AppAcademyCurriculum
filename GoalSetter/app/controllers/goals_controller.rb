class GoalsController < ApplicationController
  before_action :require_logged_in
  before_action :require_owns_goal, only: [:edit, :update, :destroy]
  before_action :require_owns_private_goal, only: :show

  def create
    @goal = current_user.goals.new(goal_params)
    if @goal.save
      redirect_to goal_url(@goal)
    else
      flash[:errors] = @goal.errors.full_messages
      render :new
    end
  end

  def destroy
    @goal = current_user.goals.find(params[:id])
    @goal.destroy
    redirect_to user_url(@goal.user)
  end

  def edit
    @goal = current_user.goals.find(params[:id])
    render :edit
  end

  def index
    @goals = Goal.all.includes(:user)
    render :index
  end

  def new
    @goal = Goal.new
    render :new
  end

  def show
    @goal = Goal.find(params[:id])
    render :show
  end

  def update
    @goal = current_user.goals.find(params[:id])
    if @goal.update(goal_params)
      redirect_to goal_url(@goal)
    else
      flash[:errors] = @goal.errors.full_messages
      render :edit
    end
  end

  private

    def goal_params
      output = params.require(:goal).permit(:title, :description, :privacy, :complete)
      output[:complete] = output[:complete] == "true"
      output
    end
end
