module Admin  
  class ModelLoadingService
    def initialize(searchable_model, params = {})  # aqui o método construtor c/ 2 parametros
      @searchable_model = searchable_model
      @params = params || {}
      @records = []
      @pagination = { page: @params[:page].to_i, length: @params[:length].to_i }
    end

    def call
      @searchable_model.search_by_name(@params.dig(:search, :name))
                       .order(@params[:order].to_h)
                       .paginate(@params[:page].to_i, @params[:length].to_i)
    end
  end

  private
  
  def fix_pagination_values
    @pagination[:page] = @searchable_model.model::DEFAULT_PAGE if @pagination[:page] <= 0
    @pagination[:length] = @searchable_model.model::MAX_PER_PAGE if @pagination[:length] <= 0
  end
end