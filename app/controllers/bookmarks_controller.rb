class BookmarksController < ApplicationController
  before_action :set_bookmark, only: [:show, :edit, :update, :destroy]

  def index
    @bookmarks = Bookmark.paginate(page: params[:page], :per_page => 20)
  end

  def show
  end

  def new
    @bookmark = Bookmark.new
  end

  def edit
  end
  

  def create
    @bookmark = Bookmark.new(bookmark_params)
    
    respond_to do |format|
      if @bookmark.save
        format.html { redirect_to bookmarks_path, notice: 'Bookmark was successfully created.' }
        format.json { render action: 'show', status: :created, location: @bookmark }
      else
        format.html { render action: 'new' }
        format.json { render json: @bookmark.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @bookmark.update(bookmark_params)
        format.html { redirect_to @bookmark, notice: 'Bookmark was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @bookamrk.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @bookmark.destroy
    respond_to do |format|
      format.html { redirect_to bookmarks_url }
      format.json { head :no_content }
    end
  end

  def add
    page = MetaInspector.new(params[:url])
    render json: { title: page.title, list: page.meta['keywords'] }
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
