class ChangeCategoryField < ActiveRecord::Migration[7.0]
  def change
    rename_column :categories, :title, :name
  end
end
