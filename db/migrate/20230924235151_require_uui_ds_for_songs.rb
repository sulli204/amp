class RequireUuiDsForSongs < ActiveRecord::Migration[7.0]
  def change
    change_column :songs, :user_id, :uuid, null: false
  end
end
