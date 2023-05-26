module Admin::V1
  class ProductsController < ApiController
    def index
      @products = load_products
    end

    def create
    end
    
    def show; end
    
    def update
    end
    
    def destroy
    end
    
    private
    
    def load_products
      permitted = params.permit({ search: :name }, { order: {} }, :page, :length)
      Admin::ModelLoadingService.new(Product.all, permitted).call
    end

    def product_params
      return {} unless params.has_key?(:product)
      permitted_params = params.require(:product).permit(:id, :name, :description, :image, 
                                                         :price, :productable,
                                                         :status, category_ids: [])
      permitted_params.merge(productable_params)
    end

    
  end
end