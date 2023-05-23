module Admin  
  class ProductSavingService
    class NotSavedProductError < StandardError; end
  
    attr_reader :product, :errors

    def initialize(params, product = nil)
      params = params.deep_symbolize_keys
      @product_params = params.reject { |key| key == :productable_attributes }
      @productable_params = params[:productable_attributes] || {}
      @errors = {}
      @product = product || Product.new
    end
  end
end