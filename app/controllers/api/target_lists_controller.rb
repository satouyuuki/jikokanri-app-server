class Api::TargetListsController < ApplicationController
  def show
    id = params[:id]
    @month = Month.find(id)
    render json: res_data(@month.target_lists)
  end
  def upsert
    @month = Month.find(params[:id])
    targets_data = target_list_params

    @month.target_lists.transaction do
      targets_data[:target_lists].each do |target_data|
        if target_data.include?(:id)
          @target_list = @month.target_lists.find(target_data[:id])
          @target_list.target_text = target_data[:target_text]
          @target_list.target_num = target_data[:target_num]
          @target_list.save!
        else
          target_data['target_text'] = target_data[:target_text]
          target_data['target_num'] = target_data[:target_num]
          @target_list = @month.target_lists.new(target_data)
          @target_list.save!
        end
      end
    end
    render json: res_data(@month.target_lists)
  end
  def destroy
    @target_list = TargetList.find(params[:id])
    @target_list.destroy!
    render json: res_data(@target_list.month.target_lists)
  end
  private
  def target_list_params
    params.require(:target_data).permit({target_lists: [:target_text, :target_num, :id]})
  end
  def res_data(target_lists)
    targets_data = []
    target_lists.each do |target_list|
      target_list_data = {}
      target_list_data[:id] = target_list.id
      target_list_data[:target_text] = target_list.target_text
      target_list_data[:target_num] = target_list.target_num
      targets_data.push(target_list_data)
    end
    targets_data
  end
end
