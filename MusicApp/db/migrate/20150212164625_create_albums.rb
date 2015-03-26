class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.string :name, null: false
      t.integer :band_id, null: false
      t.integer :recording_type, default: 0
      t.integer :recording_year
    end

    add_index(:albums, :band_id)
    add_index(:albums, :name)
    add_index(:albums, [:name, :recording_year, :band_id], unique: true)
  end
end
