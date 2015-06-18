require 'spec_helper'

describe User, type: :model do
  it { is_expected.to have_many :restaurants }
  it { is_expected.to have_many :reviews }
#the above two lines are equivelent of the line below..
  it { is_expected.to have_many :reviewed_restaurants}
end
