defmodule ServerWeb.Router do
  use ServerWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  # scope "/user/", ServerWeb do
  #   pipe_through :api
  #   post "/sign_in", UserController, :sign_in
  #   put "/sign_out/:userId", UserController, :sign_out
  # end

  scope "/api", ServerWeb do
    pipe_through :api

    post "/createUser", UserController, :createUser    
    post "/sign_in", UserController, :sign_in

    scope "/user/:userId" do
      put "/sign_out", UserController, :sign_out

      get "/info", UserController, :getInfoUser
      put "/update", UserController, :updateInfoUser
      delete "/delete", UserController, :deleteUser
      post "/clockIn", WorkingtimeController, :clockIn
      put "/clockOut", WorkingtimeController, :clockOut
      
      get "/getWorkingTimeForUser", WorkingtimeController, :getWorkingTimeForUser
    end

    scope "/manager" do
      get "/user_list", UserController, :getUserList
      post "/team", TeamController, :create
    end

    scope "/general" do
    end
  end
end
