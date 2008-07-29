class FlickrSearchesController < ApplicationController
  # GET /flickr_searches
  # GET /flickr_searches.xml
  def index
    @current_flickr_searches = FlickrSearch.find(:all, :conditions => ["completed = ?", false])
    @prev_flickr_searches = FlickrSearch.find(:all, :conditions => ["completed = ?", true])

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @flickr_searches }
    end
  end

  # GET /flickr_searches/1
  # GET /flickr_searches/1.xml
  def show
    @flickr_search = FlickrSearch.find(params[:id], :order => "search_parameter DESC")

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @flickr_search }
    end
  end

  # GET /flickr_searches/new
  # GET /flickr_searches/new.xml
  def new
    @flickr_search = FlickrSearch.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @flickr_search }
    end
  end

  # GET /flickr_searches/1/edit
  def edit
    @flickr_search = FlickrSearch.find(params[:id])
  end

  # POST /flickr_searches
  # POST /flickr_searches.xml
  def create
    @flickr_search = FlickrSearch.new(params[:flickr_search])

    respond_to do |format|
      if @flickr_search.save
        # Spawn forks so that this won't hang up the whole process
        spawn do
          @flickr_search.execute
        end
        flash[:notice] = 'Now Downloading from Flickr. Please Be Patient'
        format.html { redirect_to(flickr_searches_url) }
        format.xml  { render :xml => @flickr_search, :status => :created, :location => @flickr_search }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @flickr_search.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /flickr_searches/1
  # PUT /flickr_searches/1.xml
  def update
    @flickr_search = FlickrSearch.find(params[:id])

    respond_to do |format|
      if @flickr_search.update_attributes(params[:flickr_search])
        flash[:notice] = 'FlickrSearch was successfully updated.'
        format.html { redirect_to(flickr_searches_url) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @flickr_search.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /flickr_searches/1
  # DELETE /flickr_searches/1.xml
  def destroy
    @flickr_search = FlickrSearch.find(params[:id])
    @flickr_search.destroy

    respond_to do |format|
      format.html { redirect_to(flickr_searches_url) }
      format.xml  { head :ok }
    end
  end
end
