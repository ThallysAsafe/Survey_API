class AddOptionsAnswerToQuestions < ActiveRecord::Migration[7.0]
  def change
    add_column :questions, :options_answer, :string, array: true, default: []
  end
end
