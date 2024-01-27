class AddStatusToResearch < ActiveRecord::Migration[7.0]
  def change
    add_column :researches, :status, :string
  end
end
