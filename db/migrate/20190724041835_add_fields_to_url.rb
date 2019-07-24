class AddFieldsToUrl < ActiveRecord::Migration[5.2]
  def change
    add_column :urls, :address, :string
  
  end
end
