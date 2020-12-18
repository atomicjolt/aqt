class AddQuizQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :quiz_questions do |t|
      t.references :quiz
      t.bigint :quiz_group_id
      t.bigint :assessment_question_id
      t.text :question_data
      t.integer :assessment_question_version
      t.integer :position
      t.timestamps
      t.string :migration_id
      t.string :workflow_state
      t.integer :duplicate_index
      t.bigint :root_account_id
    end
  end
end
