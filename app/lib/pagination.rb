# frozen_string_literal: true

module Pagination
  DEFAULT_PAGE_SIZE = 25
  MAX_PAGE_SIZE = 100

  def pagination_data(relation)
    {
      meta: {
        #total_pages: relation.total_pages,
        current_page: relation.current_page,
        next_page: relation.next_page,
        per_page: relation.limit_value,
        #total_count: relation.total_count
      }
    }
  end

  def per_page(params_per_page)
    [(params_per_page || DEFAULT_PAGE_SIZE).to_i, MAX_PAGE_SIZE].min
  end
end
