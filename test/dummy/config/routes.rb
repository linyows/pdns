Rails.application.routes.draw do
  mount Pdns::Engine => "/pdns"
end
