class AddExtraFieldsToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :school, :string
    add_column :users, :company, :string
    add_column :users, :title, :string
    add_column :users, :description, :string
    add_column :users, :city, :string
    add_column :users, :linkedin_url, :string
  end
end
