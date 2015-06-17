require 'rails_helper'

feature 'reviewing' do
  # before {Restaurant.create name: 'KFC'}

  def sign_up(email='test@example.com')
    visit '/'
    click_link 'Sign up'
    fill_in "Email", with: email
    fill_in "Password", with: 'testtest'
    fill_in "Password confirmation", with: 'testtest'
    click_button 'Sign up'
  end

  def sign_out
    visit '/'
    click_link 'Sign out'
  end

  def create_restaurant(name='KFC')
    visit '/restaurants'
    click_link 'Add a restaurant'
    fill_in 'Name', with: name
    click_button 'Create Restaurant'
  end


  scenario 'allows users to leave a review using a form' do
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

end
