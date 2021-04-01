# class TargetListService
#   class << self
#     def res_data(target_lists)
#       targets_data = []
#       target_lists.each do |target_list|
#         target_list_data = {}
#         target_list_data[:id] = target_list.id
#         target_list_data[:target_text] = target_list.target_text
#         target_list_data[:target_num] = target_list.target_num
#         targets_data.push(target_list_data)
#       end
#       targets_data
#     end
#   end
# end