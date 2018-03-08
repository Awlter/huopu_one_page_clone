class AddDateToPagesViewCounts < ActiveRecord::Migration[5.1]
  def change
    add_column :pages_view_counts, :date, :string
  end
end
