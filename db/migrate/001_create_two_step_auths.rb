class CreateTwoStepAuths < ActiveRecord::Migration
  def change
    create_table :two_step_auths do |t|
      t.string :secret
      t.integer :counter, default: 0
      t.boolean :enabled, default: false
      t.references :user, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end