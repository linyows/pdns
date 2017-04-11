Pengine::Engine.routes.draw do
  domain_regex = /[a-z0-9\-\._]*\.[a-z0-9-]{2,}/
  resources :domains, only: %i(create show destroy), id: domain_regex do
    resources :records, except: %i(index new edit), id: domain_regex
    put 'force_update_records', to: 'records#force_update_records'
  end
end
