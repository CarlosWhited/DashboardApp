class AddRequestCountToTenants < ActiveRecord::Migration
  def change
    add_column :tenants, :request_count, :integer, default: 0, null: false
  end
end
