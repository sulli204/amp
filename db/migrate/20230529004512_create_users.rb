class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users, id: :uuid do |t|
      t.string :name
      t.string :username
      t.string :email, index: { unique: true, name: 'unique_emails' }
      t.string :profile_page, unique: true

      t.timestamps
    end
  end
end
