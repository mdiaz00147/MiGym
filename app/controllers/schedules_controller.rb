class SchedulesController < ApplicationController
  before_action :check_expiration, only: [:new, :appointment]

  def index
      if params[:search].present?
        fecha           =   params[:search][:start_date]
        fecha_start     =   fecha.to_time.beginning_of_day
        fecha_end       =   fecha.to_time.end_of_day
        @assistance     =   Schedule.where(start_date: (fecha_start)..fecha_end).order(start_date: :asc)
      else 
        @assistance    =  Schedule.where(start_date: (Time.now.beginning_of_day)..Time.now.end_of_day).order(start_date: :asc)
      end
      
    


  end
  def dynash
    auth = {:username => "elite_fitness", :password => "3li73Services+-*"}
    @blah = HTTParty.get("http://services.dynash.com/index.php/users/sessionsatdate/", 
                     :basic_auth => auth)

    @array_lessons    = Array(@blah)[1][1]

    @array_lessons.each do |ass|
      @user_start_hour  = (Array(ass)[5][1]).to_time(:utc)
      @user_complete    = (Array(ass)[3][1]).to_s + (Array(ass)[4][1]).to_s
      @check            = Schedule.where("options = '#{@user_complete}' AND start_date = '#{(Array(ass)[5][1])}.000000'")
      if @check.empty?
        @lesson_find      = Lesson.find_by(start_date: @user_start_hour)
        @new_enrolled     = @lesson_find.users_enrolled + 1
        @lesson_find.update_attribute(:users_enrolled, @new_enrolled)
        @lesson_dy        = Schedule.new(user_id: 60,
                                         lesson_id: @lesson_find.id,
                                         options: @user_complete,
                                         start_date: @user_start_hour)
        @lesson_dy.save
      end
    end
      flash["success"]  = "dynash actualizado"
      redirect_to asistencia_path
  end
  def new
    @user               = User.find(current_user.id)
    @plan               = @user.plan
    @schedules          = @user.schedules.pluck(:lesson_id)
    @arr_lessons_user   = Array(@schedules)

    if Time.now.wday == 0
      if @plan.start_hour == '06:00'
      @lessons_0  = Lesson.where(start_date: (Time.now.beginning_of_week.next_week.beginning_of_day)..Time.now.next_week.beginning_of_week.end_of_day).order(start_date: :asc)
      @lessons_1  = Lesson.where(start_date: (Time.now.beginning_of_week.next_week.beginning_of_day + 1.days)..Time.now.next_week.beginning_of_week.end_of_day + 1.days).order(start_date: :asc)
      @lessons_2  = Lesson.where(start_date: (Time.now.beginning_of_week.next_week.beginning_of_day + 2.days)..Time.now.next_week.beginning_of_week.end_of_day + 2.days).order(start_date: :asc)
      @lessons_3  = Lesson.where(start_date: (Time.now.beginning_of_week.next_week.beginning_of_day + 3.days)..Time.now.next_week.beginning_of_week.end_of_day + 3.days).order(start_date: :asc)
      @lessons_4  = Lesson.where(start_date: (Time.now.beginning_of_week.next_week.beginning_of_day + 4.days)..Time.now.next_week.beginning_of_week.end_of_day + 4.days).order(start_date: :asc)
      @lessons_5  = Lesson.where(start_date: (Time.now.beginning_of_week.next_week.beginning_of_day + 5.days)..Time.now.next_week.beginning_of_week.end_of_day + 5.days).order(start_date: :asc)
      @lessons_6  = Lesson.where(start_date: (Time.now.beginning_of_week.next_week.beginning_of_day + 6.days)..Time.now.next_week.beginning_of_week.end_of_day + 6.days).order(start_date: :asc)
      @news = ['@lessons_0', '@lessons_1', '@lessons_2', '@lessons_3', '@lessons_4', '@lessons_5', '@lessons_6']
      else
      @lessons_0  = Lesson.where(start_date: (Time.zone.now.beginning_of_week.next_week.beginning_of_day + @plan.start_hour.to_i.hours)..Time.zone.now.next_week.beginning_of_week.beginning_of_day + @plan.end_hour.to_i.hours).order(start_date: :asc)
      @lessons_1  = Lesson.where(start_date: (Time.zone.now.beginning_of_week.next_week.beginning_of_day + 1.days + @plan.start_hour.to_i.hours)..Time.zone.now.next_week.beginning_of_week.beginning_of_day + 1.days + @plan.end_hour.to_i.hours).order(start_date: :asc)
      @lessons_2  = Lesson.where(start_date: (Time.zone.now.beginning_of_week.next_week.beginning_of_day + 2.days + @plan.start_hour.to_i.hours)..Time.zone.now.next_week.beginning_of_week.beginning_of_day + 2.days + @plan.end_hour.to_i.hours).order(start_date: :asc)
      @lessons_3  = Lesson.where(start_date: (Time.zone.now.beginning_of_week.next_week.beginning_of_day + 3.days + @plan.start_hour.to_i.hours)..Time.zone.now.next_week.beginning_of_week.beginning_of_day + 3.days + @plan.end_hour.to_i.hours).order(start_date: :asc)
      @lessons_4  = Lesson.where(start_date: (Time.zone.now.beginning_of_week.next_week.beginning_of_day + 4.days + @plan.start_hour.to_i.hours)..Time.zone.now.next_week.beginning_of_week.beginning_of_day + 4.days + @plan.end_hour.to_i.hours).order(start_date: :asc)
      @lessons_5  = Lesson.where(start_date: (Time.zone.now.beginning_of_week.next_week.beginning_of_day + 5.days + @plan.start_hour.to_i.hours)..Time.zone.now.next_week.beginning_of_week.beginning_of_day + 5.days + @plan.end_hour.to_i.hours).order(start_date: :asc)
      @lessons_6  = Lesson.where(start_date: (Time.zone.now.beginning_of_week.next_week.beginning_of_day + 6.days + @plan.start_hour.to_i.hours)..Time.zone.now.next_week.beginning_of_week.beginning_of_day + 6.days + @plan.end_hour.to_i.hours).order(start_date: :asc)
      @news = ['@lessons_0', '@lessons_1', '@lessons_2', '@lessons_3', '@lessons_4', '@lessons_5', '@lessons_6']
      end
    else
      if @plan.start_hour == '06:00'
      @lessons_0  = Lesson.where(start_date: (Time.now.beginning_of_week.beginning_of_day)..Time.now.beginning_of_week.end_of_day).order(start_date: :asc)
      @lessons_1  = Lesson.where(start_date: (Time.now.beginning_of_week.beginning_of_day + 1.days)..Time.now.beginning_of_week.end_of_day + 1.days).order(start_date: :asc)
      @lessons_2  = Lesson.where(start_date: (Time.now.beginning_of_week.beginning_of_day + 2.days)..Time.now.beginning_of_week.end_of_day + 2.days).order(start_date: :asc)
      @lessons_3  = Lesson.where(start_date: (Time.now.beginning_of_week.beginning_of_day + 3.days)..Time.now.beginning_of_week.end_of_day + 3.days).order(start_date: :asc)
      @lessons_4  = Lesson.where(start_date: (Time.now.beginning_of_week.beginning_of_day + 4.days)..Time.now.beginning_of_week.end_of_day + 4.days).order(start_date: :asc)
      @lessons_5  = Lesson.where(start_date: (Time.now.beginning_of_week.beginning_of_day + 5.days)..Time.now.beginning_of_week.end_of_day + 5.days).order(start_date: :asc)
      @lessons_6  = Lesson.where(start_date: (Time.now.beginning_of_week.beginning_of_day + 6.days)..Time.now.beginning_of_week.end_of_day + 6.days).order(start_date: :asc)
      @news = ['@lessons_0', '@lessons_1', '@lessons_2', '@lessons_3', '@lessons_4', '@lessons_5', '@lessons_6']
      else
      @lessons_0  = Lesson.where(start_date: (Time.zone.now.beginning_of_week.beginning_of_day + @plan.start_hour.to_i.hours)..Time.zone.now.beginning_of_week.beginning_of_day + @plan.end_hour.to_i.hours).order(start_date: :asc)
      @lessons_1  = Lesson.where(start_date: (Time.zone.now.beginning_of_week.beginning_of_day + 1.days + @plan.start_hour.to_i.hours)..Time.zone.now.beginning_of_week.beginning_of_day + 1.days + @plan.end_hour.to_i.hours).order(start_date: :asc)
      @lessons_2  = Lesson.where(start_date: (Time.zone.now.beginning_of_week.beginning_of_day + 2.days + @plan.start_hour.to_i.hours)..Time.zone.now.beginning_of_week.beginning_of_day + 2.days + @plan.end_hour.to_i.hours).order(start_date: :asc)
      @lessons_3  = Lesson.where(start_date: (Time.zone.now.beginning_of_week.beginning_of_day + 3.days + @plan.start_hour.to_i.hours)..Time.zone.now.beginning_of_week.beginning_of_day + 3.days + @plan.end_hour.to_i.hours).order(start_date: :asc)
      @lessons_4  = Lesson.where(start_date: (Time.zone.now.beginning_of_week.beginning_of_day + 4.days + @plan.start_hour.to_i.hours)..Time.zone.now.beginning_of_week.beginning_of_day + 4.days + @plan.end_hour.to_i.hours).order(start_date: :asc)
      @lessons_5  = Lesson.where(start_date: (Time.zone.now.beginning_of_week.beginning_of_day + 5.days + @plan.start_hour.to_i.hours)..Time.zone.now.beginning_of_week.beginning_of_day + 5.days + @plan.end_hour.to_i.hours).order(start_date: :asc)
      @lessons_6  = Lesson.where(start_date: (Time.zone.now.beginning_of_week.beginning_of_day + 6.days + @plan.start_hour.to_i.hours)..Time.zone.now.beginning_of_week.beginning_of_day + 6.days + @plan.end_hour.to_i.hours).order(start_date: :asc)
      @news = ['@lessons_0', '@lessons_1', '@lessons_2', '@lessons_3', '@lessons_4', '@lessons_5', '@lessons_6']
      end
    end 
  end

  def appointment
    
    users_allowed       =   params[:schedule][:users_allowed].to_i
    lesson_id           =   params[:schedule][:lesson_id]
    deleteU             =   params[:schedule][:delete].to_i
    users_enrolled      =   params[:schedule][:users_enrolled].to_i

      if deleteU == 1
          @delete_schedule    =   Schedule.find_by(user_id: current_user.id, lesson_id: lesson_id)
          @user_new           =   User.find(current_user.id)
          @lesson_new         =   Lesson.find(lesson_id)
          @new_user_lessons   =   current_user.lessons + 1
          @users_enrolled     =   users_enrolled - 1

          @lesson_new.update_attribute(:users_enrolled, @users_enrolled)
          @user_new.update_attribute(:lessons, @new_user_lessons)
          @delete_schedule.destroy

            if  @delete_schedule.destroy 
                  flash[:warning] = "Sesion cancelada!!!"
                  redirect_to calendario_path
              else
                  flash[:danger]  = "Ooops... algo ha fallado, intentalo de nuevo"
                  redirect_to calendario_path
            end
      else
        if current_user.lessons > 0
          if users_allowed  != users_enrolled 

            @appointment        =   Schedule.new(schedule_params)
            @user_new           =   User.find(current_user.id)
            @lesson_new         =   Lesson.find(lesson_id)
            @users_enrolled     =   users_enrolled + 1
            @new_user_lessons   =   current_user.lessons - 1
            @appointment.start_date = @lesson_new.start_date
            @user_new.update_attribute(:lessons, @new_user_lessons)
            @lesson_new.update_attribute(:users_enrolled, @users_enrolled)

            if @appointment.save
                flash[:success] = "Sesion agendada!!!"
                redirect_to calendario_path
            else
                flash[:warning]  = "Ooops... algo ha fallado, intentalo de nuevo"
                redirect_to calendario_path
            end
          else
            flash[:warning]  = "Ooops... Ya no hay cupos disponibles"
            redirect_to calendario_path
          end

        else
            flash[:warning]  = "Ooops... Ya no Tienes mas sesiones disponibles"
            redirect_to calendario_path
        end

      end
  end

end

 private
    def schedule_params
      params.require(:schedule).permit(:user_id, :lesson_id)
    end
    def lesson_params
      params.require(:schedule).permit(:user_id, :lesson_id)
    end
    def check_expiration
      @expiration_user  = User.find(current_user.id)
      if @expiration_user.expiry_at < Time.zone.now
          flash[:warning] = "Ooops..."
          redirect_to contactanos_path
      end
    end