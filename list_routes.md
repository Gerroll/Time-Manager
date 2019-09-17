routes define in server/lib/server_web/router.ex

all:
- create user acount
# TODO - login ?

users:
- get user info from userID
- update user account from userID
- delete user account
- create workingTime from userID and update workingTime start from userID
- update workingTime end from userID
- get all workingTime from userID (dashboard)


managers, general managers:
- create team
- get user list
# TODO - update user team from userID
# TODO - delete team from teamID

# TODO - get team list from userID (managerID)
# TODO - get user list from teamID
# TODO - get workingTime averge team daily/weekly over given periode
# TODO - get workingTime user daily/weekly over given periode
# TODO - get dashboard of userID


general managers:
# TODO - get user list
# TODO - update user rank from userID
# TODO - get dashboard from userID
# TODO - delete user from userID



mix phx.new server --no-html --no-webpack

mix phx.gen.json GTeams Team teams name:string

mix phx.gen.json GUsers User users username:string email:string password:string rank:string

mix phx.gen.json GWorkingtimes Workingtime workingtimes start:datetime end:datetime user_id:references:users

mix phx.gen.json GLinkTeams LinkTeam linkteams team_id:references:teams user_id:references:users manager:boolean
## OLD CMD :
##      mix phx.gen.json GRanks Rank ranks name:string
##      mix phx.gen.json GUsers User users username:string email:string password:string team_id:references:teams rank_id:references:ranks

on_delete: :delete_all



  def create(conn, %{"team" => team_params}) do
    teams = GTeams.list_teams()
    exist = Enum.any?(teams, fn(t) -> t.name == team_params["name"] end)
    if !exist do
      with {:ok, %Team{} = team} <- GTeams.create_team(team_params) do
        conn
        |> put_status(:created)
        |> render("show.json", team: team)
      end
    else
      conn
      |> put_status(:bad_request)
      |> json("KO : team name already taken")
    end
  end
