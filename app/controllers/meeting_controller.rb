class MeetingController < ApplicationController
  
  def new
    @meeting = Meeting.new
  end
  
  def index
    @meetings = Meeting.all
    @me = Meeting.paginate(page: params[:page])
  end
  
  def create
    @meeting = Meeting.new(meeting_params)
    if @meeting.save
      flash[:info] = "スケジュールの登録が完了しました"
      redirect_to meeting_index_path
    else
      render 'new'
    end
  end

  private

    def meeting_params
      params.require(:meeting).permit(:title, :content, :start_time, :user_id)
    end
  
end