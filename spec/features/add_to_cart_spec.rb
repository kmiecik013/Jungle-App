require 'rails_helper'

RSpec.feature "Visitor navigates to home page", type: :feature, js: true do

    before :each do
      @category = Category.create! name: 'Apparel'

      1.times do |n|
        @category.products.create!(
          name:  Faker::Hipster.sentence(3),
          description: Faker::Hipster.paragraph(4),
          image: open_asset('apparel1.jpg'),
          quantity: 10,
          price: 64.99
        )
      end
    end

    scenario "User can see a product" do
      visit root_path
      expect(page).to have_css 'article.product', count: 1
    end

    scenario "User can see the 'add to cart button'" do
      visit root_path
      expect(page).to have_button("Add", visible: true)
    end

    scenario "there should initially be 0 items in the users cart" do
      visit root_path
      expect(page).to have_content "My Cart (0)"
    end

    scenario "User can click on 'Add to Cart' and have it add to your cart and update with 'My Cart (1)'" do
      visit root_path
      click_on 'Add'
      expect(page).to have_text "My Cart (1)"
    end

end