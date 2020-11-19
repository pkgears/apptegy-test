class CreateAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :addresses do |t|
      t.string :address
      t.string :city
      t.string :state
      t.string :zip
      t.references :addressable, polymorphic: true, index: true

      t.timestamps
    end
  end
end
