Rails.application.routes.draw do
  root to: "page#front"
  get '/front', to: "page#front"
  get '/statistics', to: "page#statistics"
end
