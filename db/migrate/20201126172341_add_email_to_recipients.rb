class AddEmailToRecipients < ActiveRecord::Migration[6.0]
  def change
    add_column :recipients, :email, :string
  end
end
