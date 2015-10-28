# This migration comes from active_audit (originally 20151028193159)
class CreateActiveAuditRules < ActiveRecord::Migration
  def change
    create_table :active_audit_rules do |t|
      t.text :data
      t.text :audit_type

      t.timestamps null: false
    end
  end
end
