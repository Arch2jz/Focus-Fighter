class CreateFocusSessions < ActiveRecord::Migration[8.0]
  def change
    create_table :focus_sessions do |t|
      t.datetime :start_time
      t.datetime :end_time
      t.integer :duration
      t.references :user, null: false, foreign_key: true
      t.references :character, null: false, foreign_key: true

      t.timestamps
    end
  end
end
