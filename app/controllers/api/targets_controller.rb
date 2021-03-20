class Api::TargetsController < ApplicationController
  def show
    @target = Target.all
    render json: @target
  end
  def create
    total_time = params[:total_time]
    achieved_text = params[:achieved_text]
    @target = Target.create(
      :total_time => total_time, 
      :achieved_text => achieved_text
    )
    render json: @target
  end
  def update
    id = params[:id]
    total_time = params[:total_time]
    achieved_text = params[:achieved_text]
    @update_target = Target.find(id)
    @update_target.update(
      :total_time => total_time, 
      :achieved_text => achieved_text
    )
    render json: @update_target
  end

  def destroy
    id = params[:id]
    Target.delete(id);
  end
end
