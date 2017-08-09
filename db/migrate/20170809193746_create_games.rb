class CreateGames < ActiveRecord::Migration[5.0]
  def change
    create_table :games do |t|
      t.integer :sets
      t.datetime :end_time
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
