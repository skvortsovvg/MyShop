class CreateVotes < ActiveRecord::Migration[7.0]
  def change
    create_table :votes do |t|
      t.references :user, null: false, foreign_key: true
      t.references :answer, null: false, foreign_key: true
      t.boolean :like, null: false
      t.timestamps
      t.index %i[user_id answer_id], unique: true
    end
  end
end
