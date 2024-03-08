module PageSearch
  def self.search(params)
    return [] unless params.present? && params[:term].present?

    Page.by_term(params[:term])
  end
end
