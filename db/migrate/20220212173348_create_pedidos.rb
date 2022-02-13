class CreatePedidos < ActiveRecord::Migration[5.2]
  def change
    create_table :pedidos do |t|
      t.boolean :status
      t.float :total

      t.timestamps
    end
  end
end
