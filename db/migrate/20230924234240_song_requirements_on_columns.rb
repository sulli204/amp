class SongRequirementsOnColumns < ActiveRecord::Migration[7.0]
  def change
    change_column :songs, :plays, :integer, default: 0
    change_column :songs, :name, :string, null: false
  end
end
