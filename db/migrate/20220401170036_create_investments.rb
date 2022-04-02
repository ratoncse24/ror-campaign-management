class CreateInvestments < ActiveRecord::Migration[6.1]
  def change
    create_table :investments do |t|
      t.references :campaign, index: true, foreign_key: true
      t.decimal :investment_amount, precision: 11, scale: 2
      t.timestamps
    end
  end
end
