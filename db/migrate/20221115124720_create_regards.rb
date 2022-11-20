class CreateRegards < ActiveRecord::Migration[7.0]
  def change
    create_table :regards do |t|
      t.string :name
      t.string :image
      t.timestamps
    end
    add_reference(:questions, :regard, foreign_key: true)
  end
end
