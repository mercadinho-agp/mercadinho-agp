class AddProdutoToCompras < ActiveRecord::Migration[5.2]
  def change
    add_reference :compras, :produto, foreign_key: true
  end
end
