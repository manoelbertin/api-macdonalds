module Admin  
  class ProductSavingService
    class NotSavedProductError < StandardError; end
  
    attr_reader :product, :errors

    def initialize(params, product = nil)
      params = params.deep_symbolize_keys # tranformo em simbolo para salvar no BD.
      # abaixo estou rejeitando o que vem do productable 
      @product_params = params.reject { |key| key == :productable_attributes }
      # e pegando todo o restante ou um hash vazio {}.
      @productable_params = params[:productable_attributes] || {}
      @errors = {} # crio um hash vazio
      @product = product || Product.new  # apanho o product ou crio um novo product
      # pra gente trabahar em cima desse Product.
    end

    def call
      # estamos trabalhando com 2 models e a transaction volta ao que era 
      # isso consequentemente não deixa o banco de dados ficar comprometido.
      Product.transaction do
        @product.attributes = @product_params.reject { |key| key == :productable }
        build_productable
      ensure
        save!
      end
    end

    def build_productable
      @product.productable ||= @product_params[:productable].camelcase.safe_constantize.new
      @product.productable.attributes = @productable_params
    end
  end
end