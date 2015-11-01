class CreateTodolistItems < ActiveRecord::Migration
  def change
    create_table :todolist_items do |t|
      t.string :content
      t.boolean :completed, default: false
      t.boolean :removed, default: false

      t.timestamps null: false
    end
  end
end
