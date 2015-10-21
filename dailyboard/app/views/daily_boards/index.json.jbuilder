json.array!(@daily_boards) do |daily_board|
  json.extract! daily_board, :id, :user_id, :create_time, :title, :content
  json.url daily_board_url(daily_board, format: :json)
end
