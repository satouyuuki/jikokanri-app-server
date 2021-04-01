class Api::MonthsController < ApplicationController
  def show
    render json: res_data
  end
  def create
    month = Month.new(
      month: params[:month],
      year: params[:year]
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
    render json: res_data
    # render json: @month, include: 'weeks'
  end
  def destroy
    id = params[:id]
    month = Month.find(id)
    month.destroy
    render json: res_data
  end
  def res_data
    months = Month.all
    res = []
    months.each do |month|
      month_data = {}
      month_data[:id] = month.id
      month_data[:year] = month.year
      month_data[:month] = month.month
      month_data[:weeks] = []
      res.push(month_data)
      weeks = month.weeks
      weeks.each do |week|
        week_data = {}
        week_data[:id] = week.id
        week_data[:week] = week.week
        month_data[:weeks].push(week_data)
      end
    end
    res
  end
end
