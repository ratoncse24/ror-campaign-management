class CreateCampaigns < ActiveRecord::Migration[6.1]
  def change
    create_table :campaigns do |t|
      t.string :name
      t.string :image
      t.float :percentage_raised, default: 0.0
      t.decimal :target_amount, precision: 11, scale: 2
      t.string :sector
      t.string :country
      t.decimal :investment_multiple, precision: 11, scale: 2
      t.timestamps
    end
  end
end
