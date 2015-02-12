class CreateTrack < ActiveRecord::Migration
  def change
    create_table :tracks do |t|
      t.string :name, null: false
      t.integer :album_id, null: false
      t.integer :track_type, default: 0
      t.text :lyrics
      t.integer :track_length
    end

    add_index(:tracks, :name)
    add_index(:tracks, :album_id)
  end
end
