class TaskBoardsController < ApplicationController
  before_action :set_task_board, only: [:show, :edit, :update, :destroy]
  before_action :authentication

  def index
    @task_boards = TaskBoard.all
    auth = cookies.permanent[:token]
    current_user_id = User.find_by_token(auth).id
    @task_boards = TaskBoard.where(:user_id => current_user_id)

  end

  def show
    @username = User.find(@task_board.user_id).name
  end

  def new
    @task_board = TaskBoard.new
  end

  def edit
  end

  def create
    @task_board = TaskBoard.new(task_board_params)
    @task_board.create_time = Time.now
    @task_board.user_id = @user.id
    respond_to do |format|
      if @task_board.save
        format.html { redirect_to @task_board, notice: 'Task board was successfully created.' }
        format.json { render :show, status: :created, location: @task_board }
      else
        format.html { render :new }
        format.json { render json: @task_board.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @task_board.update(task_board_params)
        format.html { redirect_to @task_board, notice: 'Task board was successfully updated.' }
        format.json { render :show, status: :ok, location: @task_board }
      else
        format.html { render :edit }
        format.json { render json: @task_board.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @task_board.destroy
    respond_to do |format|
      format.html { redirect_to task_boards_url, notice: 'Task board was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def show_all    
    auth = cookies.permanent[:token]
    @user = User.find_by_token(auth)
    @user_lists = User.all
    if ((check_nil(params[:year]) || check_nil(params[:month]) || check_nil(params[:day])) &&  !check_nil(params[:selected_user]))
      @task_boards = TaskBoard.where(:user_id => params[:selected_user].to_i)
      @user_select = params[:selected_user]
    elsif ((check_nil(params[:year]) || check_nil(params[:month]) || check_nil(params[:day])) &&  check_nil(params[:selected_user]))
      @task_boards = TaskBoard.all
    elsif ((!check_nil(params[:year]) && !check_nil(params[:month]) && !check_nil(params[:day])) &&  check_nil(params[:selected_user]))
      year = params[:year].to_i
      month = params[:month].to_i
      day = params[:day].to_i
      puts year,month,day
      puts 'hahhha'
      @date = Time.new(year,month,day)
      @date_end = @date + 86400
      @task_boards = TaskBoard.where(:create_time => @date...@date_end)
      @year_select = params[:year]
      @month_select = params[:month]
      @day_select = params[:day]
    else 
      year = params[:year].to_i
      month = params[:month].to_i
      day = params[:day].to_i
      # if(params[:selected_user] == nil)
      #   @task_boards = TaskBoard.all
      # else
        @date = Time.new(year,month,day)
        @date_end = @date + 86400
        @task_boards_by_id = TaskBoard.where(:user_id => params[:selected_user].to_i)
        @task_boards = @task_boards_by_id.where(:create_time => @date...@date_end)
        @user_select = params[:selected_user]
        @year_select = params[:year]
        @month_select = params[:month]
        @day_select = params[:day]
    end
  end
  
  private
    def set_task_board
      @task_board = TaskBoard.find(params[:id])
    end

    def task_board_params
      params.require(:task_board).permit(:user_id, :create_time, :title, :content)
    end

    def authentication
      auth = cookies.permanent[:token]
      if (auth == nil)
        redirect_to :login
      else
        @user = User.find_by_token(auth)
      end 
    end
    def check_nil(is_nil)
      if (is_nil == "nil" || is_nil == "" || is_nil == nil)
        return true
      else
        return false
      end
    end
end
