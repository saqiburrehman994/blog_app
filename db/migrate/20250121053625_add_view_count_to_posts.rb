class AddViewCountToPosts < ActiveRecord::Migration[7.2]
  def change
    add_column :posts, :view_count, :integer
  end
end
