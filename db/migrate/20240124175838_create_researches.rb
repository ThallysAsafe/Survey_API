class CreateResearches < ActiveRecord::Migration[7.0]
  def change
    create_table :researches do |t|
      t.string :title
      t.references :research, null: false, foreign_key: true

      t.timestamps
    end
  end
end
