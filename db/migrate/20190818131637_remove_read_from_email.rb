class RemoveReadFromEmail < ActiveRecord::Migration[5.2]
  def change
    remove_column :emails, :read, :boolean
  end
end
