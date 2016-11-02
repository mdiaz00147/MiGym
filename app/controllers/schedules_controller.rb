class SchedulesController < ApplicationController
  before_action :check_login, only: [:index, :new, :appointment]
  before_action :check_expiration, only: [:new, :appointment]

  def index
      if params[:search].present?
        fecha           =   params[:search][:start_date]
        fecha_start     =   fecha.to_time.beginning_of_day
        fecha_end       =   fecha.to_time.end_of_day
        @assistance     =   Schedule.joins(:lesson).select(:id,'lessons.start_date as start_date',:options,:user_id,:lesson_id).where("lessons.start_date BETWEEN '#{fecha_start}' AND '#{fecha_end}'").order("lessons.start_date ASC")     
      else
          @assistance       = Schedule.joins(:lesson ).select(:id,'lessons.start_date as start_date', :options,:user_id,:lesson_id ).where("lessons.start_date BETWEEN '#{Time.now.beginning_of_day}' AND '#{Time.now.end_of_day}'").order("lessons.start_date ASC")
           
      end
  end
  def dynash
    auth = {:username => "elite_fitness", :password => "3li73Services+-*"}
    @blah = HTTParty.get("http://services.dynash.com/index.php/users/sessionsatdate/", 
                     :basic_auth => auth)

    @array_lessons      = Array(@blah)[1][1]

    @array_lessons.each do |ass|
      @user_start_hour  = (Array(ass)[5][1]).to_time(:utc)
      @user_complete    = (Array(ass)[3][1]).to_s + (Array(ass)[4][1]).to_s
      # @check            = Schedule.where("options = '#{@user_complete}' AND start_date = '#{(Array(ass)[5][1])}.000000'")
      @lesson = Lesson.find_by(start_date: @user_start_hour)
      @check  = Schedule.where(options: @user_complete, lesson_id: @lesson.id).first
      if !@check.present?
        @lesson_find      = Lesson.find_by(start_date: @user_start_hour)
        @new_enrolled     = @lesson_find.users_enrolled + 1
        @lesson_find.update_attribute(:users_enrolled, @new_enrolled)
        @lesson_dy        = Schedule.new(user_id: 60,
                                         lesson_id: @lesson_find.id,
                                         options: @user_complete)
        @lesson_dy.save
      end
    end
      flash["success"]  = "dynash actualizado"
      redirect_to asistencia_path
  end
  def btce
    require 'btce'
    require 'json'
    key     = 'IK3CWYP2-E0BK49OV-I5HM6H47-8EXPEMRF-HVGMHZFT'
    secret  = '0575f08d23450cad862925e4af06b70c0177d722d00a2b745ac66de56b610a2c'
    login   = Btce::TradeAPI.new(key: key, secret: secret)
    accion  = params[:string].to_s
    @price  = Btce::Ticker.new "btc_usd"
    @cuenta_orders      = login.order_list
    @cuenta_info        = login.get_info
    @cuenta_history     =  login.trade_history['return']
    @cuenta_history_type = (@cuenta_history.to_s.split('"')[9])

    @compra = (@price.buy.to_f - 1.5.to_f).round(2)
    # @venta  = (@price.sell.to_f + 1.5.to_f).round(2)
    @venta  = ((@cuenta_history.to_s.split('>')[5]).to_f + 1.5)

    @cantidad_btc  = ((@cuenta_info["return"]["funds"]["usd"].to_f / @compra) - 0.0001).round(4)
    @cantidad_usd  = (@cuenta_info["return"]["funds"]["btc"].to_f - 0.0001).round(4)
    case accion
      when 'compra'
          @trade = login.trade(pair: 'btc_usd', type: 'buy', rate: @compra, amount: @cantidad_btc)
      when 'venta'        
          @trade = login.trade(pair: 'btc_usd', type: 'sell', rate: @venta, amount: @cantidad_usd)
      when 'ordenes'
          @cuenta_orders  = @cuenta_orders
      when 'cancelar'
          trans_id = (params[:trans_id]).to_i
          # render html: trans_id.class
          @trade = login.cancel_order(order_id: trans_id)
     end

  end
  def btce_automated
    require 'btce'
    require 'json'
    key     = 'IK3CWYP2-E0BK49OV-I5HM6H47-8EXPEMRF-HVGMHZFT'
    secret  = '0575f08d23450cad862925e4af06b70c0177d722d00a2b745ac66de56b610a2c'
    login   = Btce::TradeAPI.new(key: key, secret: secret)
    accion  = params[:string].to_s
    @price  = Btce::Ticker.new "btc_usd"
    @cuenta_orders      = login.order_list

    if !@cuenta_orders['return'].present?
        @cuenta_history     = login.trade_history['return']
        @cuenta_history_type = (@cuenta_history.to_s.split('"')[9])
        @cuenta_info        = login.get_info
        @compra = (@price.buy.to_f - 1.5.to_f).round(2)
        @venta  = ((@cuenta_history.to_s.split('>')[5]).to_f + 1.5)
        
        @cantidad_btc  = ((@cuenta_info["return"]["funds"]["usd"].to_f / @compra) - 0.0001).round(4)
        @cantidad_usd  = (@cuenta_info["return"]["funds"]["btc"].to_f - 0.0001).round(4)

      if @cuenta_history_type.to_s == 'buy'
        @trade = login.trade(pair: 'btc_usd', type: 'sell', rate: @venta, amount: @cantidad_usd)
        render html: { :test => @trade, :tess => 'venta', :sj => @cuenta_info }
      else
        @trade = login.trade(pair: 'btc_usd', type: 'buy', rate: @compra, amount: @cantidad_btc)
        render html: { :test => @trade, :tess => 'compra', :sj => @cuenta_history_type }
      end

    else
      render html: 'Hay operaciones pendientes'
    end
  end
  def new
      if Time.now.wday == 7
        @todas      =   Lesson.all.select(:id,:name,:users_enrolled,:users_allowed,:start_date).where(start_date: (Time.now.next_week.beginning_of_week.beginning_of_day)..Time.now.next_week.end_of_week.end_of_day).order(start_date: :asc)
      else
        @todas      =   Lesson.all.select(:id,:name,:users_enrolled,:users_allowed,:start_date).where(start_date: (Time.now.beginning_of_week.beginning_of_day)..Time.now.end_of_week.end_of_day).order(start_date: :asc)
      end
      @days =  [@mon = [], @tue = [], @wed = [], @thu = [], @fri = [], @sat = []]

      @schedules          = current_user.schedules.pluck(:lesson_id)
      @arr_lessons_user   = Array(@schedules)
      @lessons = []
      stores = Struct.new(:day, :lessons)

      @days.each do |ri, ro|
        @lessons.push stores.new(ri, 0)
      end
 
      @todas.each do |lesson|
      case (lesson.start_date.wday).to_i
        when 1
          @mon << lesson
        when 2
          @tue << lesson
         when 3
          @wed << lesson
         when 4
          @thu << lesson
         when 5
          @fri << lesson
         when 6
          @sat << lesson
        end
      end
      # render json: @mon
  end
  def new2
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
            # @appointment.start_date = @lesson_new.start_date
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
    def check_login
      if !logged_in?
        redirect_to root_path
      end
    end
