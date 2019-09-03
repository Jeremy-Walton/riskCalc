class AddPlayers < ActiveRecord::Migration[6.0]
  def change
    create_table :players do |t|
      t.string :name
      t.integer :luck
      t.integer :luckwins
      t.integer :lucklosses
      t.integer :wins
      t.integer :losses
      t.integer :ratio
      t.integer :streak_count
      t.integer :streak
      t.timestamps
    end
  end
end
