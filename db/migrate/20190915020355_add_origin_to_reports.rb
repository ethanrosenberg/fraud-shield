class AddOriginToReports < ActiveRecord::Migration[5.2]
  def change
    add_column :reports, :origin, :string
  end
end
