class AddPublishedToPosts < ActiveRecord::Migration[7.2]
  def change
    add_column :posts, :published, :boolean, default: true
  end
end
