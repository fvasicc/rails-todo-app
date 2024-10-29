class AddDateToTodos < ActiveRecord::Migration[7.2]
  def change
    add_column :todos, :date, :date
  end
end
