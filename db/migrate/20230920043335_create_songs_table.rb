class CreateSongsTable < ActiveRecord::Migration[7.0]
  def change
    create_table :songs, id: :uuid do |t|
      t.string :name
      t.belongs_to :user, foreign_key: true, type: :uuid
      t.string :file_path
      t.string :album_art
      t.integer :plays
      t.timestamps
    end
  end
end
