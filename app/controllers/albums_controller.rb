class AlbumsController < ApplicationController

  def index
    if params[:page]
      @page = params[:page]
    else
      @page = 1
    end

    if params[:sort_by]
      case params[:sort_by]
      when 'name, asc', 'name, desc', 'created_at, asc', 'created_at, desc'
        method = params[:sort_by].split(', ')
        puts method
        @albums = Album.sort_by_method(method).page(@page)
      when 'most_songs'
        @albums = Album.most_songs.page(@page)
      else
        flash[:notice] = "Invalid sorting method"
        @albums = Album.page(@page)
      end
    elsif params[:search]
      @albums = Album.search(params[:search]).page(@page)
      @search = true
    else
      @albums = Album.all.page(@page)
    end
    
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
    if params[:artist_to_add]
      artist = Artist.find(params[:artist_to_add])
      if @album.artists.include? artist
        flash[:notice] = "Relationship already exists!"
      else
        @album.artists << artist
      end
    elsif params[:artist_to_remove]
      artist = Artist.find(params[:artist_to_remove])
      if @album.artists.include? artist
        @album.artists.delete(artist)
      else
        flash[:notice] = "Relationship does not exist."
      end
    end
    @artists = Artist.all
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