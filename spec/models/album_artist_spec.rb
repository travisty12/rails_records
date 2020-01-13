require 'rails_helper'

describe AlbumArtist do
  it { should belong_to(:album) }
  it { should belong_to(:artist) }
end