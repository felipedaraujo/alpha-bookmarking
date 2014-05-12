module BookmarksHelper
  def current_domain
    @domain = Domain.find(params[:id])
  end

  def tags
    
  end
end
