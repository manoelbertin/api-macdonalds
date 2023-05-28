json.products do
  json.array! @loading_service.records do |product|
    json.partial! product # chama _product.json.jbuilder
    json.partial! product.productable # chama _game.json.jbuilder
  end
end