class CreateTasks < ActiveRecord::Migration[5.1]
  def change
    create_table :tasks do |t|
      t.bigint :lesson_id, index: true
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end