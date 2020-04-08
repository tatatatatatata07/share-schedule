class MeetingController < ApplicationController
  before_action :logged_in_user
  before_action :correct_or_admin_user,   only: :destroy
  before_action :mix_time, only: :create
  
  def new
    @meeting = Meeting.new
  end
  
  def index
    if logged_in?
     # @micropost  = current_user.microposts.build
      #@feed_items = current_user.feed.paginate(page: params[:page])
    end
    @meetings = Meeting.all
    if flash[:create_meeting]
      
    end
  end
  
  def create
    @meeting = current_user.meeting.build(meeting_params)
    @meeting.start_time = @start_time
    #debugger
    if @meeting.save
      flash[:info] = "#{@meeting.start_time.month}月#{@meeting.start_time.day}日のスケジュールに「#{@meeting.title}」を追加しました"
      
      #createで作られたスケジュールのページネーションのページを検索
      #時間区切りができていないため未実装
      @page_number = 1
      while @page_number > 0 
      	day_meetings = Meeting.where( "start_time LIKE ?", "#{@meeting.start_time.to_s[0,10]}%").paginate(page: @page_number, per_page: 3)
      	if day_meetings.ids.include? @meeting.id
      	  #debugger
      		break
      	end
      	@page_number = @page_number + 1
      end
      #flash[:create_meeting] = @meeting 
      redirect_to meeting_index_path("#{@meeting.start_time.to_s[0,10]}": @page_number)
    else
      render 'new'
    end
  end
  
  def destroy
    @meeting.destroy
    flash[:success] = "#{@meeting.start_time.month}月#{@meeting.start_time.day}日のスケジュール「#{@meeting.title}」を削除しました"
    redirect_to request.referrer || root_url
  end

  private

    def meeting_params
      params.require(:meeting).permit(:title, :content, :start_date, :start_hour, :start_minute)
    end
    
    def create_page
      params.require(:"#{@meeting.start_time.to_s[0,10]}").permit(:page_number)
    end
  
    def correct_or_admin_user
      if !current_user.admin?
        @meeting = current_user.meeting.find_by(id: params[:id])
        redirect_to root_url if @meeting.nil?
      else
        @meeting = Meeting.find_by(id: params[:id])
      end

    end
    
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
    
    def mix_time
      @start_time = params[:meeting][:start_date] + " " + params[:meeting][:start_hour] + ":" + params[:meeting][:start_minute]   
      #debugger
    end
    
end