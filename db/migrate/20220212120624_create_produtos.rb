class CreateProdutos < ActiveRecord::Migration[5.2]
  def change
    create_table :produtos do |t|
      t.string :nome
      t.text :descricao
      t.float :preco
      t.integer :qnt

      t.timestamps
    end
  end
end
