class RenameBoleto < ActiveRecord::Migration
  def self.up
    rename_table :spree_boletos, :spree_boleto_docs
  end

  def self.down
    rename_table :spree_boleto_docs, :spree_boletos
  end
end
