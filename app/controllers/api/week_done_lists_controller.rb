class Api::WeekDoneListsController < ApplicationController
  def show
    week_id = params[:week_id]
    render json: res_data(week_id)
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
    render json: res_data(week_id)
  end

  def destroy
    done_list = WeekDoneList.find(params[:id])
    done_list.destroy!
    render json: res_data(done_list.week_id)
  end


  private
  def done_list_params
    params.require(:done_data).permit(:week_id, {done_lists: [:target_list_id, :done_num]})
  end
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
