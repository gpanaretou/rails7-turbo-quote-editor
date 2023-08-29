class AddGuestToCompanies < ActiveRecord::Migration[7.0]
  def change
    add_column :companies, :guest, :boolean
  end
end
