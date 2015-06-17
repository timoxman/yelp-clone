require 'rails_helper'

feature 'restaurants' do

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

  context 'no restaurants have been added' do
    scenario 'should display a prompt to add a restaurant' do
      sign_up
      visit '/restaurants'
      expect(page).to have_content 'No restaurants yet'
      expect(page).to have_link 'Add a restaurant'
    end
  end

  context 'restaurants have been added' do
    # before do
    #   Restaurant.create(name: 'KFC')
    # end
    scenario 'display restaurants' do
      sign_up
      create_restaurant
      visit '/restaurants'
      expect(page).to have_content('KFC')
      expect(page).not_to have_content('No restaurants yet')
    end
  end

  context 'creating restaurants' do
    scenario 'prompts user to fill out a form, then displays the new restaurant' do
        sign_up
        visit '/restaurants'
        click_link 'Add a restaurant'
        fill_in 'Name', with: 'KFC'
        click_button 'Create Restaurant'
        expect(page).to have_content 'KFC'
        expect(current_path).to eq '/restaurants'
    end
  end

  context 'viewing restaurants' do
    # let!(:kfc){Restaurant.create(name: 'KFC')}
    scenario 'lets a user view a restaurant' do
      sign_up
      create_restaurant
      visit '/restaurants'
      click_link 'KFC'
      expect(page).to have_content 'KFC'
      # expect(current_path).to eq "/restaurants/#{kfc.id}"
    end
  end

  context 'editing restaurants' do

    scenario 'let a user edit a restaurant' do
      sign_up
      create_restaurant
      visit '/restaurants'
      click_link 'Edit KFC'
      fill_in 'Name', with: 'Kentucky Fried Chicken'
      click_button 'Update Restaurant'
      expect(page).to have_content 'Kentucky Fried Chicken'
      expect(current_path).to eq '/restaurants'
    end
  end

  context 'deleting restaurants' do

    # before {Restaurant.create name: 'KFC'}
    # before {create_restaurant}

    scenario 'removes a restaurant when the creator clicks a delete link' do
      sign_up
      create_restaurant
      visit '/restaurants'
      click_link 'Delete KFC'
      expect(page).not_to have_content 'KFC'
      expect(page).to have_content 'Restaurant deleted successfully'
    end

    scenario 'cannot edit or remove another user created restaurant' do
      sign_up
      create_restaurant
      sign_out
      sign_up('bob@mcbobs.com')
      visit '/restaurants'
      expect(page).not_to have_content 'Delete KFC'
      expect(page).not_to have_content 'Edit KFC'
    end

  end

  context 'deleting restaurants with reviews' do

    # before {Restaurant.create name: 'KFC'}

    scenario 'removes a restaurant and associated reviews when a user clicks a delete link' do
      sign_up
      create_restaurant
      visit '/restaurants'
      click_link 'Review KFC'
      fill_in "Thoughts", with: "so so"
      select '3', from: 'Rating'
      click_button 'Leave Review'
      click_link 'Delete KFC'
      expect(page).not_to have_content 'KFC'
      expect(page).to have_content 'Restaurant deleted successfully'
      expect(page).not_to have_content('so so')
    end
  end

  context 'an invalid restaurant' do
    it 'does not let you submit a resturant if name is too short' do
      sign_up
      visit '/restaurants'
      click_link 'Add a restaurant'
      fill_in 'Name', with: 'kf'
      click_button 'Create Restaurant'
      expect(page).not_to have_css 'h2', text: 'kf'
      expect(page).to have_content 'error'
    end
  end

  context 'adding a restaurant' do
    it 'only allows you to add a a restaurant when you are already logged in' do
      visit '/restaurants'
      expect(page).not_to have_content 'Add a restaurant'
    end
  end










end
