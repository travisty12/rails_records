require 'rails_helper'

describe Album do
  it { should have_many(:songs) }

  it { should validate_presence_of :name }

  it { should validate_length_of(:name).is_at_most(100)}
end