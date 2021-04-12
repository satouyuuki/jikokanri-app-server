class TargetListService
  class << self
    def res_data(target_lists)
      targets_data = {}
      targets_data[:target_lists] = []
      target_lists.each do |target_list|
        target_list_data = {}
        target_list_data[:id] = target_list.id
        target_list_data[:target_text] = target_list.target_text
        target_list_data[:target_num] = target_list.target_num
        # 達成数の合計値
        target_list_data[:done_num_sum] = target_list.week_done_lists.all.sum(:done_num)
        # 月の情報取得
        targets_data[:month] = target_list.month.month
        
        targets_data[:target_lists].push(target_list_data)
      end
      targets_data
    end
  end
end