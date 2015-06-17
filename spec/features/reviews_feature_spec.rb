require 'rails_helper'
require_relative 'helpers'
include Helpers

feature 'reviewing' do
  # before {Restaurant.create name: 'KFC'}

  scenario 'allows users to leave a review using a form (R01)' do
    sign_up
    create_restaurant
    visit '/restaurants'
    click_link 'Review KFC'
    fill_in "Thoughts", with: "so so"
    select '3', from: 'Rating'
    click_button 'Leave Review'

    expect(current_path).to eq '/restaurants'
    expect(page).to have_content('so so')
  end

  context 'User can only leave one review per restaurant' do
    scenario 'after adding a review the add review button should not be present (R02)' do
      sign_up
      create_restaurant
      visit '/restaurants'
      click_link 'Review KFC'
      fill_in "Thoughts", with: "so so"
      select '3', from: 'Rating'
      click_button 'Leave Review'
      visit '/restaurants'
      expect(page).not_to have_link 'Review KFC'
    end
  end





end
