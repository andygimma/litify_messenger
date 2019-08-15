class CreateEmails < ActiveRecord::Migration[5.2]
  def change
    create_table :emails do |t|
      t.belongs_to :user, foreign_key: true
      t.string :subject, null: false
      t.text :body, null: false
      t.boolean :read, default: false, null: false

      t.timestamps
    end
  end
end
