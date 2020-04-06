class MeetingController < ApplicationController
  
  before_action :logged_in_user
  
  def new
    @meeting = Meeting.new
  end
  
  def index
    @meetings = Meeting.all
  end
  
  def create
    @meeting = current_user.meeting.build(meeting_params)
    if @meeting.save
      flash[:info] = "スケジュールの登録が完了しました"
      redirect_to meeting_index_path
    else
      render 'new'
    end
  end
  
  def destroy
  end

  private

    def meeting_params
      params.require(:meeting).permit(:title, :content, :start_time)
    end
  
end