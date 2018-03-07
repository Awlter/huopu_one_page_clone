class CreateUniqueVisitors < ActiveRecord::Migration[5.1]
  def change
    create_table :unique_visitors do |t|
      t.string :ip
      t.timestamps
    end
  end
end
