require 'test_helper'

class DailyBoardsControllerTest < ActionController::TestCase
  setup do
    @daily_board = daily_boards(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:daily_boards)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create daily_board" do
    assert_difference('DailyBoard.count') do
      post :create, daily_board: { content: @daily_board.content, create_time: @daily_board.create_time, title: @daily_board.title, user_Id: @daily_board.user_Id }
    end

    assert_redirected_to daily_board_path(assigns(:daily_board))
  end

  test "should show daily_board" do
    get :show, id: @daily_board
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @daily_board
    assert_response :success
  end

  test "should update daily_board" do
    patch :update, id: @daily_board, daily_board: { content: @daily_board.content, create_time: @daily_board.create_time, title: @daily_board.title, user_Id: @daily_board.user_Id }
    assert_redirected_to daily_board_path(assigns(:daily_board))
  end

  test "should destroy daily_board" do
    assert_difference('DailyBoard.count', -1) do
      delete :destroy, id: @daily_board
    end

    assert_redirected_to daily_boards_path
  end
end
