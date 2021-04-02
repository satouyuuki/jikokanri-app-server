class MonthService
  class << self
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
end