class CreateTaskBoards < ActiveRecord::Migration
  def change
    create_table :task_boards do |t|
      t.integer :user_id
      t.date :create_time
      t.string :title
      t.string :content

      t.timestamps null: false
    end
  end
end
