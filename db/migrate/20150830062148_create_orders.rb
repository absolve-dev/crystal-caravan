class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :first_name_billing
      t.string :last_name_billing
      t.string :company_billing
      t.string :address_line_one_billing
      t.string :address_line_two_billing
      t.string :city_billing
      t.string :country_billing
      t.string :state_billing
      t.integer :zip_billing
      t.string :phone_billing
      t.string :first_name_shipping
      t.string :last_name_shipping
      t.string :company_shipping
      t.string :address_line_one_shipping
      t.string :address_line_two_shipping
      t.string :city_shipping
      t.string :country_shipping
      t.string :state_shipping
      t.integer :zip_shipping
      t.string :phone_shipping

      t.timestamps null: false
    end
  end
end
