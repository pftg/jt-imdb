class CreateMovies < ActiveRecord::Migration[6.0]
  def change
    create_table :movies do |t|
      t.string :title
      t.text :text
      t.string :category
      t.integer :ratings_count
      t.integer :ratings_sum

      t.timestamps
    end

    add_index :movies, :category, using: 'btree'
  end
end
