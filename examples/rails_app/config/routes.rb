require 'momm/web'

Myapp::Application.routes.draw do
  root 'pages#say_hello'

  mount Momm::Web => '/momm'
end
