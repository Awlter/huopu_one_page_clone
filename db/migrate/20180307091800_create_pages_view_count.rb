class CreatePagesViewCount < ActiveRecord::Migration[5.1]
  def change
    create_table :pages_view_counts do |t|
      t.string :page_title
      t.decimal :counter, default: 0
      t.timestamps
    end
  end
end
