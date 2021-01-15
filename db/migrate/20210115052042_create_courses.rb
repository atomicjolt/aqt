class CreateCourses < ActiveRecord::Migration[5.2]
  def up
    create_table :courses, id: false do |t|
      t.bigint :id, null: false
    end
    execute "ALTER TABLE courses ADD PRIMARY KEY (id);"
  end

  def down
    drop_table :courses
  end
end
