class CreateActivityLogs < ActiveRecord::Migration
  def change
    create_table :activity_logs do |t|
      t.integer :tenant_id

      t.timestamps null: false
    end
  end
end
