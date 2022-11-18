class CreateRegards < ActiveRecord::Migration[7.0]
  def change
    create_table :regards do |t|
      t.string :name
      t.string :image
      t.belongs_to :question, foreign_key: true

      t.timestamps
    end
  end
end
