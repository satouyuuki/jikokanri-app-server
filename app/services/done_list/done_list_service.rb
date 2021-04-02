class DoneListService
  class << self
    def res_data(week_id)
      week = Week.find(week_id)
      month = week.month
      target_lists = month.target_lists
      done_lists = week.week_done_lists
      res = {}
      res[:week] = week.week
      res[:month] = month.month
      res[:year] = month.year
      res[:done_lists] = []
      target_lists.each do |target_list|
        target_list_obj = {}
        target_list_obj[:target_list_id] = target_list.id
        target_list_obj[:target_text] = target_list.target_text
        target_list_obj[:target_num] = target_list.target_num
        
        done_list = target_list.week_done_lists.where(target_list_id: target_list.id, week_id: week_id)
        if done_list.exists?
          target_list_obj[:done_num] = done_list.first.done_num
          target_list_obj[:done_list_id] = done_list.first.id
        end

        res[:done_lists].push(target_list_obj)
      end
      res
    end
  end
end