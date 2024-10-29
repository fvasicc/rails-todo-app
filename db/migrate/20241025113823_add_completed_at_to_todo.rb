class AddCompletedAtToTodo < ActiveRecord::Migration[7.2]
  def change
    add_column :todos, :completed_at, :timestamp
  end
end
