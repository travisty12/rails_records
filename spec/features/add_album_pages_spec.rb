require 'rails_helper'

describe "album creation" do
  it "adds a new album" do
    visit albums_path
    click_link 'Create new album'
    fill_in 'Name', :with => 'Nevermind'
    fill_in 'Genre', :with => 'Rock'
    click_on 'Create Album'
    expect(page).to have_content 'Album added safely!'
    expect(page).to have_content 'Nevermind'
  end

  it "throws an error with no name" do
    visit new_album_path
    click_on 'Create Album'
    expect(page).to have_content "Name can't be blank"
  end
end