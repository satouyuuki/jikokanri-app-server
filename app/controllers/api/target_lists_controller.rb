class Api::TargetListsController < ApplicationController
  def show
    id = params[:id]
    @month = Month.find(id)
    render json: @month.target_lists
  end
  # def create
  #   @month = Month.find(params[:id])
  #   targets_data = target_list_params
    
  #   @month.target_lists.transaction do
  #     targets_data[:target_lists].each do |target_data|
  #       target_data['target_text'] = target_data[:target_text]
  #       target_data['target_num'] = target_data[:target_num]
  #       # target_lists << @month.target_lists.new(target_data)
  #       @target_list = @month.target_lists.new(target_data)
  #       @target_list.save!
  #     end      
  #   end
  #   # @month.target_lists.import target_lists, on_duplicate_key_update: [:target_text, :target_num]

  #   render json: @month.target_lists
  # end
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
    render json: @month.target_lists
  end
  def destroy
    id = params[:id]
    @target_list = TargetList.delete(id)
    # 帰ってこない
    render json: @target_list
  end
  private
  def target_list_params
    params.require(:target_data).permit({target_lists: [:target_text, :target_num, :id]})
  end
end
