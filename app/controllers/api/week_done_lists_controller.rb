class Api::WeekDoneListsController < ApplicationController
  def show
    week_id = params[:week_id]
    render json: DoneListService.res_data(week_id)
  end
  def upsert
    done_datas = done_list_params
    week_id = done_datas[:week_id]
  
    WeekDoneList.transaction do
      done_datas[:done_lists].each do |done_data|
        done_list = WeekDoneList.where(target_list_id: done_data[:target_list_id], week_id: week_id)
        if done_list.exists?
          done_list.first.done_num = done_data[:done_num]
          done_list.first.save!
        else
          done_data['week_id'] = week_id
          done_data['target_list_id'] = done_data[:target_list_id]
          done_data['done_num'] = done_data[:done_num]
          done_list = WeekDoneList.new(done_data)
          done_list.save!
        end
      end
    end
    render json: DoneListService.res_data(week_id)
  end

  def destroy
    done_list = WeekDoneList.find(params[:id])
    done_list.destroy!
    render json: DoneListService.res_data(done_list.week_id)
  end


  private
  def done_list_params
    params.require(:done_data).permit(:week_id, {done_lists: [:target_list_id, :done_num]})
  end
end
