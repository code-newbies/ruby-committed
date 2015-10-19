class AchievementsController < ApplicationController
  before_action :find_achievement, only: [:show, :edit, :update, :destroy]

  def new
    @achievement = Achievement.new
  end

  def create
    @achievement = Achievement.new(achievement_params)
    if @achievement.save
      redirect_to @achievement
    else
      render 'new'
    end
  end

  def show
  end

  def index
    @achievements = Achievement.all
  end

  def edit
  end

  def update
    if @achievement.update(achievement_params)
      redirect_to @achievement
    else
      render 'edit'
    end
  end

  def destroy
    @achievement.destroy
    redirect_to achievements_path
  end

  private

    def find_achievement
      @achievement = Achievement.find(params[:id])
    end

    def achievement_params
      params.require(:achievement).permit(:title, :description, :points)
    end
end
