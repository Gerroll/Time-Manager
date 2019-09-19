defmodule ServerWeb.Router do
  use ServerWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end
  pipeline :userToken do
    plug Server.UserTokenPlug
  end

  pipeline :managerToken do
    plug Server.ManagerTokenPlug
  end

  pipeline :generalToken do
    plug Server.GeneralTokenPlug
  end

  ### TMP ###
  get "/listTeam", ServerWeb.TeamController, :index
  get "/listLink", ServerWeb.LinkTeamController, :index
  ### TMP ###

  scope "/api", ServerWeb do
    pipe_through :api

    post "/createUser", UserController, :createUser
    post "/sign_in", UserController, :sign_in

    scope "/user/:userId" do
      pipe_through :userToken

      put "/sign_out", UserController, :sign_out
      get "/info", UserController, :getInfoUser
      put "/update", UserController, :updateInfoUser
      delete "/delete", UserController, :deleteUser
      post "/clockIn", WorkingtimeController, :clockIn
      put "/clockOut", WorkingtimeController, :clockOut
      get "/getWorkingTimeForUser", WorkingtimeController, :getWorkingTimeForUser
    end

    scope "/manager" do
      pipe_through :managerToken

      get "/user_list", UserController, :getUserList
      get "/user_list_in_team", UserController, :getUserListInTeam
      get "/user_list_not_in_team", UserController, :getUserListNotInTeam
      post "/createTeam", TeamController, :create
      put "/updateTeam", TeamController, :update
      delete "/deleteTeam", TeamController, :delete
      # post "/team", TeamController, :create
    end

    scope "/general" do
      pipe_through :generalToken
    end
  end
end
