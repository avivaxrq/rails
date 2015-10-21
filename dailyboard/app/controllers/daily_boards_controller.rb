class DailyBoardsController < ApplicationController
  before_action :set_daily_board, only: [:show, :edit, :update, :destroy]

  # GET /daily_boards
  # GET /daily_boards.json
  def index
    @daily_boards = DailyBoard.all
  end

  # GET /daily_boards/1
  # GET /daily_boards/1.json
  def show
  end

  # GET /daily_boards/new
  def new
    @daily_board = DailyBoard.new
  end

  # GET /daily_boards/1/edit
  def edit
  end

  # POST /daily_boards
  # POST /daily_boards.json
  def create
    @daily_board = DailyBoard.new(daily_board_params)

    respond_to do |format|
      if @daily_board.save
        format.html { redirect_to @daily_board, notice: 'Daily board was successfully created.' }
        format.json { render :show, status: :created, location: @daily_board }
      else
        format.html { render :new }
        format.json { render json: @daily_board.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /daily_boards/1
  # PATCH/PUT /daily_boards/1.json
  def update
    respond_to do |format|
      if @daily_board.update(daily_board_params)
        format.html { redirect_to @daily_board, notice: 'Daily board was successfully updated.' }
        format.json { render :show, status: :ok, location: @daily_board }
      else
        format.html { render :edit }
        format.json { render json: @daily_board.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /daily_boards/1
  # DELETE /daily_boards/1.json
  def destroy
    @daily_board.destroy
    respond_to do |format|
      format.html { redirect_to daily_boards_url, notice: 'Daily board was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_daily_board
      @daily_board = DailyBoard.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def daily_board_params
      params.require(:daily_board).permit(:user_id, :create_time, :title, :content)
    end
end
