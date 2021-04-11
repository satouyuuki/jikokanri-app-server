class Api::MonthsController < ApplicationController
  def show
    logger.debug('current_user = ')
    logger.debug(current_user)
    logger.debug(current_user.id)
    logger.debug('current_user end ')
    months = Month.where(user_id: current_user.id)
    render json: MonthService.res_data(months)
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

    months = Month.where(user_id: current_user.id)
    render json: MonthService.res_data(months)
  end
  def destroy
    id = params[:id]
    month = Month.find(id)
    month.destroy

    months = Month.where(user_id: current_user.id)
    render json: MonthService.res_data
  end
end
