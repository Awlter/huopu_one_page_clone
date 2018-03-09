Rails.application.routes.draw do
  root to: "page#front"
  get '/front', to: "page#front"
  get '/statistics', to: "page#statistics"
  get '/search_by_date', to: "page#search_by_date"
end
