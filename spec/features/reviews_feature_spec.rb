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

  scenario 'displays an average rating for all reviews' do
    sign_up
    create_restaurant
    leave_review('So so', '3')
    sign_out
    sign_up("hallo@yomama.com")
    leave_review('Great', '5')
    expect(page).to have_content('Average rating: 4')
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

  context 'User can delete their own review' do
    scenario 'after adding a review the delete review button should be present(R03)' do
      sign_up
      create_restaurant
      visit '/restaurants'
      click_link 'Review KFC'
      fill_in "Thoughts", with: "so so"
      select '3', from: 'Rating'
      click_button 'Leave Review'
      visit '/restaurants'
      expect(page).to have_link 'Delete Review'
    end
    scenario 'after adding a review the review can be deleted(R04)' do
      sign_up
      create_restaurant
      visit '/restaurants'
      click_link 'Review KFC'
      fill_in "Thoughts", with: "so so"
      select '3', from: 'Rating'
      click_button 'Leave Review'
      visit '/restaurants'
      click_link 'Delete Review'
      expect(page).not_to have_content('so so')
    end
  end

  context 'User cannot delete someone elses review' do
    scenario 'after adding a review the delete review button should not be present(R05)' do
      sign_up
      create_restaurant
      visit '/restaurants'
      click_link 'Review KFC'
      fill_in "Thoughts", with: "so so"
      select '3', from: 'Rating'
      click_button 'Leave Review'
      sign_out
      sign_up("bob@bob.com")
      visit '/restaurants'
      expect(page).to have_content('so so')
      expect(page).not_to have_link 'Delete Review'
    end
  end







end
