class CreatePagesViewCount < ActiveRecord::Migration[5.1]
  def change
    create_table :pages_view_counts do |t|
      t.string :page_title
      t.integer :counter, default: 1
      t.timestamps
    end
  end
end
