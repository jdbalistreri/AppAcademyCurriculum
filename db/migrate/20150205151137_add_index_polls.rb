class AddIndexPolls < ActiveRecord::Migration
  def change
    add_index :polls, :author_id
  end
end
