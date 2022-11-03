class CreateConfigs < ActiveRecord::Migration[7.0]
  def change
    create_table :configs do |t|
      t.string :key, index: true, null: false
      t.string :value, null: false
      t.string :kind, null: false

      t.timestamps
    end
  end
end
