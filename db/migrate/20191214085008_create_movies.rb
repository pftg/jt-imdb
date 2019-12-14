class CreateMovies < ActiveRecord::Migration[6.0]
  def change
    create_table :movies do |t|
      t.string :title
      t.text :text
      t.string :category
      t.integer :ratings_count
      t.timestamps
    end

    add_index :movies, :category, using: 'btree', order: { title: :asc, id: :desc }
  end
end
