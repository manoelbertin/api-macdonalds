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
      ensure # garantir q próx método rodará!
        save! # esse save NÃO é do Active Record, daí temos que criá-lo lá embaixo!!
      end
    end

    def build_productable
      # abaixo estou recebendo o nome do nosso productable em camelcase
      @product.productable ||= @product_params[:productable].camelcase.safe_constantize.new
      # ou já há o productable ou vamos criar um new productable.
      @product.productable.attributes = @productable_params
    end

    def save!
      save_record!(@product.productable) if @product.productable.present?
      save_record!(@product)
      raise NotSavedProductError if @errors.present? # se há erro daí nós levantamos
    rescue => e # vai se recuperar desse erro
      raise NotSavedProductError # aqui caso tenha um erro que exploda possivelmente.
    end

    def save_record!(record)
      record.save! # aqui eu chamo o save do ActiveRecord.
    rescue ActiveRecord::RecordInvalid
      @errors.merge!(record.errors.messages) # faço o merge (adiciono) em @erros.
    end
  end
end