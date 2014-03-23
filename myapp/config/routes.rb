require 'momm/web'

Myapp::Application.routes.draw do
  mount Momm::Web => '/momm'
end
