Routes define in server/lib/server_web/router.ex

all:
- create user acount
- login user(sign_in)

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
- get user list
# TODO - update user rank from userID
# TODO - get dashboard from userID
# TODO - delete user from userID


mix phx.new server --no-html --no-webpack

mix phx.gen.json GTeams Team teams name:string

mix phx.gen.json GUsers User users username:string email:string password:string rank:string token:string

mix phx.gen.json GWorkingtimes Workingtime workingtimes start:datetime end:datetime user_id:references:users

mix phx.gen.json GLinkTeams LinkTeam linkteams team_id:references:teams user_id:references:users manager:boolean