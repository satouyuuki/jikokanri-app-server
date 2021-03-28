class Api::WeekDoneListsController < ApplicationController
  def show
    @done_lists = WeekDoneList.where(week_id: params[:week_id])
    render json: res_data(@done_lists)
  end
  def create
    done_datas = done_list_params

    WeekDoneList.transaction do
      done_datas[:done_lists].each do |done_data|
        done_data['week_id'] = done_datas[:week_id]
        done_data['target_list_id'] = done_data[:target_list_id]
        done_data['done_num'] = done_data[:done_num]
        @done_list = WeekDoneList.new(done_data)
        @done_list.save!
      end
    end
    render json: @done_list
  end

  private
  def done_list_params
    params.require(:done_data).permit(:week_id, {done_lists: [:target_list_id, :done_num]})
  end
  def res_data(done_lists)
    done_datas = []
    done_lists.each do |done_list|
      done_list_data = {}
      done_list_data[:id] = done_list.id
      done_list_data[:week_id] = done_list.week_id
      done_list_data[:target_text] = done_list.target_list.target_text
      done_list_data[:target_num] = done_list.target_list.target_num
      done_list_data[:done_num] = done_list.done_num
      done_datas.push(done_list_data)
    end
    done_datas
  end

end
