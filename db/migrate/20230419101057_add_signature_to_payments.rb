class AddSignatureToPayments < ActiveRecord::Migration[7.0]
  def change
    add_column :payments, :signature, :string
  end
end
