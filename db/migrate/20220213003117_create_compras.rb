class CreateCompras < ActiveRecord::Migration[5.2]
  def change
    create_table :compras do |t|
      t.integer :qnt
      t.float :sub_total

      t.timestamps
    end
  end
end
