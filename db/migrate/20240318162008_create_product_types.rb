class CreateProductTypes < ActiveRecord::Migration[7.1]
  def change
    create_table :product_types do |t|
      t.string :name

      t.timestamps
    end
  end
end
