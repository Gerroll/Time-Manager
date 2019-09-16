defmodule ServerWeb.Router do
  use ServerWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", ServerWeb do
    pipe_through :api

    post "/createUser", UserController, :createUser    

    scope "/user" do
    end

    scope "/manager" do
      get "/user_list", UserController, :getUserList
      post "/team", TeamController, :create
    end

    scope "/general" do
    end
  end
end
