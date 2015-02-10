class CreateCat < ActiveRecord::Migration
  def change
    create_table :cats do |t|
      t.date :birth_date, null: false
      t.string :color
      t.string :name, null: false
      t.string :sex
      t.text :description

      t.timestamps
    end
  end
end
