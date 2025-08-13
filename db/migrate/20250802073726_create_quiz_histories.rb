class CreateQuizHistories < ActiveRecord::Migration[8.0]
  def change
    create_table :quiz_histories do |t|
      t.references :user, null: false, foreign_key: true
      t.string :quiz_topic
      t.string :level
      t.integer :score
      t.integer :total_questions
      t.integer :correct_answers
      t.integer :attempted_questions
      t.datetime :attempted_at

      t.timestamps
    end
  end
end
