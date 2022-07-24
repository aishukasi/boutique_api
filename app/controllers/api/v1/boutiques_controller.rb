require "json"
class Api::V1::BoutiquesController < ApplicationController
  # Get
  def order
    begin
      total_cost = 0.0
      discount_cost = 0.0
      param[:cart][:items].each do |item|
        inventory = Inventory.find_by(skuid: item[:skuid])
        category_names = inventory.category.ancestores.pluck(:name)
        category_names << inventory.brand
        discount = Discount.where(discount_on: category_names).maximum(:discount_precentage)
        price_before_discount = item[:unitsbought] * Float(inventory.list_price)
        price_after_discount = item[:unitsbought] * ((discount *  Float(inventory.list_price)) / 100 )
        total_cost = price_before_discount + total_cost
        discount_cost = price_after_discount + discount_cost
      end
    rescue Exception
      render json: { error: 'Error in processing request'}, status: 422
    end
    return render json: {} status: 404 if total_cost == 0.0
    render json: {price_before_discount: total_cost, price_after_discount: discount_cost, total_savings: total_cost - discount_cost}, status: 200
  end

  # POST
  def catalog
    begin
      ActiveRecord::Base.transaction do
        inventory_json = File.open "C:/Users/Dinesh/botique_api/Inventory.json"
        inventory_attrs = JSON.load(inventory_json)["Inventory"].map { |inventory|
          {
            skuid: inventory["SKUID"].to_i,
            brand: inventory["Brand"], 
            category_name: inventory["Category"], 
            list_price: inventory["ListPrice"].to_f,
            created_at: Time.now,
            updated_at: Time.now
          }
        }
        Inventory.upsert_all(inventory_attrs, unique_by: [:skuid])

        discount_json = File.open "C:/Users/Dinesh/botique_api/Discounts.json"
        discount_attrs = JSON.load(discount_json)["Discount"].map { |discount|
          {
            discount_type: discount["Discount_Type"],
            discount_on: discount["Discount_On"], 
            discount_precentage: discount["Discount"].to_i,
            created_at: Time.now,
            updated_at: Time.now
          }
        }
        Discount.upsert_all(discount_attrs)
      end
      render json: {}, status: 200
    rescue Exception
      render json: { error: 'Error in processing request'}, status: 422
    end
  end
end
