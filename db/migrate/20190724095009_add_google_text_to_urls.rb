class AddGoogleTextToUrls < ActiveRecord::Migration[5.2]
  def change
    add_column :urls, :google_text, :text
  end
end
