class CreateRatings < ActiveRecord::Migration[6.0]
  def change
    create_table :ratings, id: false do |t|
      t.integer :value, null: false, default: 5
      t.references :user, null: false, foreign_key: true
      t.references :movie, null: false, foreign_key: true

      t.timestamps
    end

    add_index :ratings, [:user_id, :movie_id], unique: true
  end
end
