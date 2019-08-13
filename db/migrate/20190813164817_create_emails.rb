class CreateEmails < ActiveRecord::Migration[5.2]
  def change
    create_table :emails do |t|
      t.belongs_to :user, foreign_key: true
      t.string :subject
      t.text :body
      t.boolean :read

      t.timestamps
    end
  end
end
