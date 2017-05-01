Pdns::Engine.routes.draw do
  resources :domains, only: %i(create show destroy), id: Pdns.domain_format_for_routes do
    resources :records, except: %i(index new edit), id: Pdns.domain_format_for_routes
    put 'force_update_records', to: 'records#force_update_records'
  end
end
