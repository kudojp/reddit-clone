class AddDefaultVotesToPost < ActiveRecord::Migration[6.0]
  def change
    change_column :posts, :upvotes, :integer, :default => 0
    change_column :posts, :downvotes, :integer, :default => 0
  end
end