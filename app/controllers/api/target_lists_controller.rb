class Api::TargetListsController < ApplicationController
  def show
    month = Month.find(params[:month_id])
    render json: TargetListService.res_data(month.target_lists)
  end
  def upsert
    targets_data = target_list_params
    month = Month.find(targets_data[:month_id])

    month.target_lists.transaction do
      targets_data[:target_lists].each do |target_data|
        if target_data.include?(:id)
          target_list = month.target_lists.find(target_data[:id])
          target_list.target_text = target_data[:target_text]
          target_list.target_num = target_data[:target_num]
          target_list.save!
        else
          target_data['target_text'] = target_data[:target_text]
          target_data['target_num'] = target_data[:target_num]
          target_list = month.target_lists.new(target_data)
          target_list.save!
        end
      end
    end
    render json: TargetListService.res_data(month.target_lists)
  end
  def destroy
    target_list = TargetList.find(params[:id])
    target_list.destroy!
    render json: TargetListService.res_data(target_list.month.target_lists)
  end
  private
  def target_list_params
    params.require(:target_data).permit(:month_id, {target_lists: [:target_text, :target_num, :id]})
  end
end
