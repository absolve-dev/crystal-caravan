class CreateDiscountCodes < ActiveRecord::Migration
  def change
    create_table :discount_codes do |t|
      t.string :name
      t.string :code
      t.integer :percentage
      t.decimal :deduction
      t.integer :usage_limit

      t.timestamps null: false
    end
  end
end
