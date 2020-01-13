class ArtistsController < ApplicationController

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
        @artists = Artist.sort_by_method(method).page(@page)
      else
        flash[:notice] = "Invalid sorting method"
        @artists = Artist.page(@page)
      end
    elsif params[:search]
      @artists = Artist.search(params[:search]).page(@page)
      @search = true
    else
      @artists = Artist.all.page(@page)
    end
    
    render :index
  end

  def new
    @artist = Artist.new 
    render :new
  end

  def create
    @artist = Artist.new(artist_params)
    if @artist.save
      flash[:notice] = "Artist added safely!"
      redirect_to artists_path
    else
      flash[:notice] = "Artist could not be added."
      render :new
    end
  end

  def edit
    @artist = Artist.find(params[:id])
    render :edit
  end

  def show
    @artist = Artist.find(params[:id])
    if params[:album_to_add]
      album = Album.find(params[:album_to_add])
      if @artist.albums.include? album
        flash[:notice] = "Relationship already exists!"
      else
        @artist.albums << album
      end
    elsif params[:album_to_remove]
      album = Album.find(params[:album_to_remove])
      if @artist.albums.include? album
        @artist.albums.delete(album)
      else
        flash[:notice] = "Relationship does not exist."
      end
    end
    @albums = Album.all
    render :show
  end

  def update
    @artist = Artist.find(params[:id])
    if @artist.update(artist_params)
      flash[:notice] = "Artist updated safely!"
      redirect_to artists_path
    else
      flash[:notice] = "Artist could not be updated."
      render :edit
    end
  end

  def destroy
    @artist = Artist.find(params[:id])
    @artist.destroy
    flash[:notice] = "Artist deleted safely!"
    redirect_to artists_path
  end

  private 
    def artist_params
      params.require(:artist).permit(:name, :genre)
    end

end