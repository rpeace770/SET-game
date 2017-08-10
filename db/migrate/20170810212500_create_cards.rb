class CreateCards < ActiveRecord::Migration[5.0]
  def change
    create_table :cards do |t|
      t.string    :color
      t.string    :fill
      t.string    :number
      t.string    :shape
      t.string    :url

      t.timestamps
  end
end
