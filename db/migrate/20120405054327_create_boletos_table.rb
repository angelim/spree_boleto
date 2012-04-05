class CreateBoletosTable < ActiveRecord::Migration
  def self.up
    create_table :spree_boletos, :force => true do |t|
      t.date      :due_date
      t.integer   :order_id
      t.string    :status
      t.decimal   :amount
      t.datetime  :paid_at
      t.text      :payload
      t.string    :document_number
      t.timestamps
    end
  end

  def self.down
    drop_table :spree_boletos
  end
end
