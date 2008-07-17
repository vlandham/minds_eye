class PhotosController < ApplicationController
  caches_page :show, :thumb
  
  # GET /photos
  # GET /photos.xml
  def index
    @photos = Photo.search(params[:search], params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @photos }
    end
  end

  # GET /photos/1
  # GET /photos/1.xml
  def show
    @photo = Photo.find(params[:id])

    respond_to do |format|
      format.jpg   # show.jpg.flexi (http://mysite.com/photos/123.jpg)
      format.html # show.html.erb
      format.xml  { render :xml => @photo }
    end
  end
  
  def thumb
    @photo = Photo.find(params[:id])
    respond_to do |format|
      format.jpg
    end
  end

  # GET /photos/new
  # GET /photos/new.xml
  def new
    @photo = Photo.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @photo }
    end
  end

  # GET /photos/1/edit
  def edit
    @photo = Photo.find(params[:id])
  end

  # POST /photos
  # POST /photos.xml
  def create
    @photo = Photo.new(params[:photo])

    respond_to do |format|
      if @photo.save
        flash[:notice] = 'Photo was successfully created.'
        format.html { redirect_to(@photo) }
        format.xml  { render :xml => @photo, :status => :created, :location => @photo }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @photo.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /photos/1
  # PUT /photos/1.xml
  def update
    @photo = Photo.find(params[:id])

    respond_to do |format|
      if @photo.update_attributes(params[:photo])
        expire_photo(@photo)
        flash[:notice] = 'Photo was successfully updated.'
        format.html { redirect_to(@photo) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @photo.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /photos/1
  # DELETE /photos/1.xml
  def destroy
    @photo = Photo.find(params[:id])
    expire_photo(@photo)
    @photo.destroy
  
    respond_to do |format|
      format.html { redirect_to(photos_url) }
      format.js
      format.xml  { head :ok }
    end
  end
  
  private
    def expire_photo(photo)
      expire_page formatted_photo_path(photo, :jpg)
      expire_page formatted_thumb_photo_path(photo, :jpg)
    end
  
end
