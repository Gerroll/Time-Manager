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
  get "/user_list", ServerWeb.UserController, :getUserList
  ### TMP ###

  scope "/api", ServerWeb do
    pipe_through :api

    post "/createUser", UserController, :createUser
    post "/sign_in", UserController, :sign_in

    scope "/" do
      pipe_through :userToken
      get "/verifyToken", UserController, :verifyToken
    end

    scope "/user" do
      pipe_through :userToken

      put "/sign_out", UserController, :sign_out
      get "/info", UserController, :getInfoUser
      put "/update", UserController, :updateInfoUser
      delete "/delete", UserController, :deleteUser
      post "/clockIn", WorkingtimeController, :clockIn
      put "/clockOut", WorkingtimeController, :clockOut
      get "/getWorkingTime", WorkingtimeController, :getWorkingTimeForUser
    end

    scope "/manager" do
      pipe_through :managerToken

      get "/user_list", UserController, :getUserList
      get "/user_list_in_team", UserController, :getUserListInTeam
      get "/user_list_not_in_team", UserController, :getUserListNotInTeam
      post "/createTeam", TeamController, :create
      get "/listTeam", TeamController, :getListTeamForManager
      put "/updateNameTeam", TeamController, :update
      delete "/deleteTeam", TeamController, :delete
      delete "/removeUserFromTeam", LinkTeamController, :removeUserFromTeam
      # post "/team", TeamController, :create
    end

    scope "/general" do
      pipe_through :generalToken
    end
  end
end
