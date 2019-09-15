defmodule ServerWeb.Router do
  use ServerWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", ServerWeb do
    pipe_through :api
      scope "/users" do
        get "/", UsersController, :index
        get "/:userID", UsersController, :show #ok
        post "/", UsersController, :create #ok
        put "/:userID", UsersController, :update #ok
        delete "/:userID", UsersController, :delete #ok
    end

    scope "/workingtimes" do
      get "/:userID/?start=XXX&end=YYY", WorkingtimesController, :index
      get "/:userID/:workingtimeID", WorkingtimesController, :show
      post "/:userID", WorkingtimesController, :create
      put "/:id", WorkingtimesController, :update
      delete "/:id", WorkingtimesController, :delete
    end

    scope "/clocks/:userID" do
      get "/", ClocksController, :index
      post "/", ClocksController, :create
    end
  end
end
