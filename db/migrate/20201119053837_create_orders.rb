class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders, &:timestamps

    create_table :gifts_orders do |t|
      t.belongs_to :gift
      t.belongs_to :order
      t.timestamps
    end

    create_table :orders_recipients do |t|
      t.belongs_to :recipient
      t.belongs_to :order
      t.timestamps
    end
  end
end
