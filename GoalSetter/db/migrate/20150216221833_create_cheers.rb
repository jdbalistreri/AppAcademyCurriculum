class CreateCheers < ActiveRecord::Migration
  def change
    create_table :cheers do |t|
      t.integer :user_id, null: false, index: true
      t.integer :goal_id, null: false, index: true
      t.timestamps
    end

    add_column :users, :cheer_count, :integer, default: 10
  end
end
