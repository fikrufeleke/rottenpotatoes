class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @all_ratings = Movie.ratings
    rts = @all_ratings
    order = ""  
    if params.has_key?(:ratings)
      rts = params[:ratings].keys
      session[:ratings] = params[:ratings]
    else if session.has_key?(:ratings)
      params[:ratings] = session[:ratings]
      rts = params[:ratings].keys
      end 
    end  
    if params.has_key?(:sort)
      session[:sort] = params[:sort]
      order = params[:sort]
     else if session.has_key?(:sort)
      params[:sort] = session[:sort]
      order = params[:sort]
      end
     end 
    @movies = Movie.find(:all, :conditions => { :rating => rts}, :order => order)
    if order == 'release_date' 
      @date_header = "hilite"
    end
    if order == 'title'
      @title_header = "hilite"
    end
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end
end
