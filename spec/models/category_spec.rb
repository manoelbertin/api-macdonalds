require 'rails_helper'

RSpec.describe Category, type: :model do
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_uniqueness_of(:name).case_insensitive }

  it { is_expected.to have_many(:product_categories).dependent(:destroy) }
  # se eu apagar uma categoria, todas associações com essa categoria apagada será destruida
  it { is_expected.to have_many(:products).through(:product_categories) }
  # 'através' dessa relação q categoria tem com product_category, vamos ter uma
  # relação DIRETA com nosso produto.
  it_behaves_like "name searchable concern", :category
  # aqui estamos incluindo um shared example e executando os testes dele.
end