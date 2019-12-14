class CreateMovies < ActiveRecord::Migration[6.0]
  def change
    create_table :movies do |t|
      t.string :title
      t.text :text
      t.references :category, null: false, foreign_key: true
      t.integer :ratings_count
      t.integer :ratings_sum

      t.timestamps
    end
  end
end
