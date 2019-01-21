module Pagination
  DEFAULT_PAGE_SIZE = 25

  def pagination_data(relation)
    {
      total_pages: relation.total_pages,
      current_page: relation.current_page,
      next_page: relation.next_page,
      per_page: relation.limit_value,
      total_count: relation.total_count
    }
  end
end
