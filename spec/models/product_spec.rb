require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    # validates :name, presence: true
    it "is can save correctly" do 
      @category = Category.new(name: "Borat's Wardrobe")
      @product = Product.new(
        name: "Borat's Mankini",
        price: 100,
        quantity: 5,
        category: @category
      )
      @product.save

    expect(@product).to be_valid
    end


    # validates :name, presence: true
    it "is invalid if missing a name attribute" do 
      @category = Category.new(name: "Borat's Wardrobe")
      @product = Product.new(
        name: nil,
        price: 100,
        quantity: 5,
        category: @category
      )
      @product.save

    expect(@product).not_to be_valid
    expect(@product.errors.full_messages).to eq(["Name can't be blank"])
    end

        # validates :category, presence: true
        it "is invalid if missing a category attribute" do
          @category = Category.new(name: "Borat's Wardrobe")
          @product = Product.new(
            name: "Borat's Mankini",
            price: 100,
            quantity: 5,
            category: nil
          )
          @product.save
  
          expect(@product).not_to be_valid
          expect(@product.errors.full_messages).to eq(["Category can't be blank"]) 
        end
  end
end