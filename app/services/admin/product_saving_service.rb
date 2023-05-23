module Admin  
  class ProductSavingService
    class NotSavedProductError < StandardError; end
  
    attr_reader :product, :errors
  end
end