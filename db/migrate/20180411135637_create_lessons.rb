class CreateLessons < ActiveRecord::Migration[5.1]
  def change
    create_table :lessons do |t|
      t.bigint :course_id, index: true
      t.text :description
      t.string :video
      t.text :material
      t.text :task

      t.timestamps
    end
  end
end
