class AddPathToReports < ActiveRecord::Migration[5.2]
  def change
    add_column :reports, :path, :string
  end
end
