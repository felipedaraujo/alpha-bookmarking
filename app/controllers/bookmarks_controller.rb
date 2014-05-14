class BookmarksController < ApplicationController
  before_action :set_bookmark, only: [:show, :update, :destroy]

  def index
    @bookmarks = Bookmark.paginate(page: params[:page], :per_page => 20)
  end

  def show
  end

  def new
    @bookmark = Bookmark.new
  end

  def edit
    @bookmark = set_bookmark
    if @bookmark.tags
      tag_list = @bookmark.tags.map do |n| 
        n.name
      end
    end
    @bookmark.tag_list = tag_list.join(", ")

  end
  

  def create
    @bookmark = Bookmark.new(bookmark_params)
    
    respond_to do |format|
      if @bookmark.save
        flash[:success] = 'Bookmark was successfully created.'
        format.html { redirect_to bookmarks_path }
        format.json { render action: 'show', status: :created, location: @bookmark }
      else
        flash[:danger] = "Error! Bookmark couldn't be created."
        format.html { render action: 'new' }
        format.json { render json: @bookmark.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @bookmark.update(bookmark_params)
        flash[:success] = 'Bookmark was successfully updated.'
        format.html { redirect_to bookmarks_path }
        format.json { head :no_content }
      else
        flash[:danger] = "Error! Bookmark couldn't be updated."
        format.html { render action: 'edit' }
        format.json { render json: @bookamrk.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @bookmark.destroy
    respond_to do |format|
      flash[:warning] = 'Bookmark was successfully deleted.'
      format.html { redirect_to bookmarks_url }
      format.json { head :no_content }
    end
  end

  def add
    page = MetaInspector.new(params[:url])
    render json: { title: page.title, list: page.meta['keywords'] }
  end

  def search
    @key = params[:key]
    @bookmarks = Bookmark.where("lower(url) like lower('%#{params[:key]}%') 
                            OR lower(title) like lower('%#{params[:key]}%')")
    if @bookmarks.empty?
      flash[:danger] = 'Link or Title were not found!'
      redirect_to bookmarks_path
    end

  end

  def search_by_tag
    @key = params[:key]
    @tags = Tag.where("lower(name) like lower('%#{params[:key]}%')")
    if @tags.empty?
      flash[:danger] = 'Tag was not found!'
      redirect_to bookmarks_path
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bookmark
      @bookmark = Bookmark.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bookmark_params
      params.require(:bookmark).permit(:url, :title, :tag_list)
    end


end
