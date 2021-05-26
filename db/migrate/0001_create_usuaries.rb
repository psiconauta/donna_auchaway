class CreateUsuaries < ActiveRecord::Migration[6.1]
  def change
    create_table :usuaries do |t|
      t.string :telegram_id
      t.string :telegram_username
      t.json :telegram_data
      t.string :pronombres
      t.string :privados

      t.timestamps
    end

    add_index :usuaries, :telegram_id, unique: true
    add_index :usuaries, :telegram_username
  end
end
