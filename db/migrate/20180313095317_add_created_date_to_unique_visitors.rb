class AddCreatedDateToUniqueVisitors < ActiveRecord::Migration[5.1]
  def change
    add_column :unique_visitors, :created_date, :string
  end
end
