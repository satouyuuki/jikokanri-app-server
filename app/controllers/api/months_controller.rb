class Api::MonthsController < ApplicationController
  def show
    @month = Month.all
    render json: @month
  end
  def create
    @month = Month.new(
      month: params[:month],
      year: params[:year]
    )
    @month.transaction do
      @month.save!
      (1..4).each do |no|
        @week = @month.weeks.new(
          week: no
        )
        @week.save!
      end
    end
    render json: @month
  end
  def destroy
    id = params[:id]
    @month = Month.find(id)
    @month.destroy
    # 帰ってくる
    render json: @month
  end
end
