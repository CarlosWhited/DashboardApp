class CreateRequestLogs < ActiveRecord::Migration
  def change
    create_table :request_logs do |t|
      t.integer :tenant_id, null:false
      t.string :search_term
      t.timestamps null: false
    end

    add_foreign_key :request_logs, :tenants
  end
end
