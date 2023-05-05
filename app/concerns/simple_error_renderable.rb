module SimpleErrorRenderable
  extend ActiveSupport::Concern

  include do
    class_attribute :simple_error_partial
  end
end