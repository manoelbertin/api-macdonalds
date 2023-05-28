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
end