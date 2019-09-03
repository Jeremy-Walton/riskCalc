class CreateRolls < ActiveRecord::Migration[5.1]
  def change
    create_table :rolls do |t|
      t.references :risk_calculator, null: false
      t.bigint :winner_id, null: false
      t.bigint :loser_id, null: false
      t.integer :die1
      t.integer :die2
      t.timestamps
    end
  end
end
