class CreateGames < ActiveRecord::Migration[5.0]
  def change
    create_table :games do |t|
      t.integer :sets, default: 0
      t.datetime :end_time
      t.references :user
      # t.integer   :user_id

      t.timestamps
    end
  end
end
