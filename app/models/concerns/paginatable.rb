module Paginatable
  extend ActiveSupport::Concern

  MAX_PER_PAGE = 10 # aqui são as 10 categorias q são devolvidas por default lá no contexto... 
  DEFAULT_PAGE = 1  # ..."When params are not present" em model_loading_service_spec.rb (teste).

  included do
    scope :paginate, -> (page, length) do
      page = page.present? && page > 0 ? page : DEFAULT_PAGE
      length = length.present? && length > 0 ? length : MAX_PER_PAGE
      starts_at = (page - 1) * length
      limit(length).offset(starts_at)
    end
  end
end