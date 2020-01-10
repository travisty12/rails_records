class SongsController < ApplicationController
  def new
    @album = Album.find(params[:album_id])
    @song = @album.songs.new
    render :new
  end
end