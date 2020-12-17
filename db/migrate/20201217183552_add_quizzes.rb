class AddQuizzes < ActiveRecord::Migration[5.2]
  def change
    create_table :quizzes do |t|
      t.string :title
      t.text :description
      t.text :quiz_data
      t.float :points_possible
      t.bigint :context_id, null: false
      t.string :context_type, null: false
      t.bigint :assignment_id
      t.string :workflow_state, null: false
      t.boolean :shuffle_answers, null: false, default: false
      t.boolean :show_correct_answers, null: false, default: true
      t.integer :time_limit
      t.integer :allowed_attempts
      t.string :scoring_policy
      t.string :quiz_type
      t.timestamps
      t.datetime :lock_at
      t.datetime :unlock_at
      t.datetime :deleted_at
      t.boolean :could_be_locked, null: false, default: false
      t.bigint :cloned_item_id
      t.string :access_code
      t.string :migration_id # not sure what this is for
      t.integer :unpublished_question_count, default: 0
      t.datetime :due_at
      t.integer :question_count
      t.bigint :last_assignment_id
      t.datetime :published_at
      t.datetime :last_edited_at
      t.boolean :anonymous_submissions, null: false, default: false
      t.bigint :assignment_group_id
      t.string :hide_results
      t.string :ip_filter
      t.boolean :require_lockdown_browser, null: false, default: false
      t.boolean :require_lockdown_browser_for_results, null: false, default: false
      t.boolean :one_question_at_a_time, null: false, default: false
      t.boolean :cant_go_back, null: false, default: false
      t.datetime :show_correct_answers_at
      t.datetime :hide_correct_answers_at
      t.boolean :require_lockdown_browser_monitor, null: false, default: false
      t.text :lockdown_browser_monitor_data
      t.boolean :only_visible_to_overrides, null: false, default: false
      t.boolean :one_time_results, null: false, default: false
      t.boolean :show_correct_answers_last_attempt, null: false, default: false
      t.bigint :root_account_id
      t.boolean :disable_timer_autosubmission, null: false, default: false
    end
  end
end
