class AddImportantToTodos < ActiveRecord::Migration[7.2]
  def change
    add_column :todos, :important, :boolean, default: false
  end
end
