class CreateStartups < ActiveRecord::Migration[6.0]
  def change
    create_table :startups do |t|
      t.string :name
      t.text :logo
      t.string :contact
      t.string :trade_registre
      t.text :adresse
      t.integer :sector_of_business
      t.text :banner
      t.text :video
      t.text :resume
      t.timestamps
    end
  end
end
