require 'spec_helper'

describe Restaurant, type: :model do
  it { is_expected.to have_many :reviews }
  it { is_expected.to belong_to :user }

  it 'is not valid with a name of less than three characters' do
  	restaurant = Restaurant.new(name: 'kf')
  	expect(restaurant).to have(1).error_on(:name)
  	expect(restaurant).not_to be_valid
  end

  it 'is not valid unless it has a unique name' do
    Restaurant.create(name: "MCDs")
    restaurant = Restaurant.new(name: "MCDs")
    expect(restaurant).to have(1).error_on(:name)
  end
end

describe '#average_rating' do
  context 'no reviews' do
    it 'returns "N/A" when there are no reviews' do
      restaurant = Restaurant.create(name: 'The Ivy')
      expect(restaurant.average_rating).to eq 'N/A'
    end
  end
end
