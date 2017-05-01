Rails.application.routes.draw do
  mount PDNS::Engine => "/pdns"
end
