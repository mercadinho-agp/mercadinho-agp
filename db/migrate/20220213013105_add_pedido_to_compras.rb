class AddPedidoToCompras < ActiveRecord::Migration[5.2]
  def change
    add_reference :compras, :pedido, foreign_key: true
  end
end
