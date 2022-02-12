class CreateProdutos < ActiveRecord::Migration[5.2]
  def change
    create_table :produtos do |t|
      t.string :name
      t.text :description
      t.float :price
      t.integer :qnt

      t.timestamps
    end
  end
end
