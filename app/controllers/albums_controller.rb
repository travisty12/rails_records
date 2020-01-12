class AlbumsController < ApplicationController

  def index
    @albums = Album.all
    render :index
  end

  def new
    @album = Album.new 
    render :new
  end

  def create
    @album = Album.new(album_params)
    if @album.save
      flash[:notice] = "Album added safely!"
      redirect_to albums_path
    else
      flash[:notice] = "Album could not be added."
      render :new
    end
  end

  def edit
    @album = Album.find(params[:id])
    render :edit
  end

  def show
    @album = Album.find(params[:id])
    render :show
  end

  def update
    @album = Album.find(params[:id])
    if @album.update(album_params)
      flash[:notice] = "Album updated safely!"
      redirect_to albums_path
    else
      flash[:notice] = "Album could not be updated."
      render :edit
    end
  end

  def destroy
    @album = Album.find(params[:id])
    @album.destroy
    flash[:notice] = "Album deleted safely!"
    redirect_to albums_path
  end

  private 
    def album_params
      params.require(:album).permit(:name, :genre)
    end

end