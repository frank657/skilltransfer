class AddFieldsToProfessional < ActiveRecord::Migration[5.2]
  def change
    add_column :professionals, :company, :string
    add_column :professionals, :title, :string
    add_column :professionals, :description, :string
    add_column :professionals, :city, :string
    add_column :professionals, :linkedin_url, :string
  end
end
