require 'rails_helper'

describe Song do
  it { should belong_to(:album) }

  it { should validate_presence_of :name }

  it { should validate_length_of(:name).is_at_most(100)}
  
end