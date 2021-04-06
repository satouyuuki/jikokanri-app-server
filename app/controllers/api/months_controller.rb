class Api::MonthsController < ApplicationController
  def show
    render json: MonthService.res_data
  end
  def create
    month = Month.new(
      month: params[:month],
      year: params[:year],
      user_id: current_user.id
    )
    month.transaction do
      month.save!
      (1..4).each do |no|
        week = month.weeks.new(
          week: no
        )
        week.save!
      end
    end
    render json: MonthService.res_data
  end
  def destroy
    id = params[:id]
    month = Month.find(id)
    month.destroy
    render json: MonthService.res_data
  end
end
