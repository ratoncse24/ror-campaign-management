module PaginationDetails
  def page_details(objects)
    {
      total_pages: (objects.total_pages || 0),
      total_objects: (objects.total_count || 0),
      current_page: objects.current_page,
      first_page: objects.first_page?,
      last_page: objects.empty? || objects.last_page?
    }
  end
end