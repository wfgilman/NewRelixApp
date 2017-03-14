# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     NewRelixApp.Repo.insert!(%NewRelixApp.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

for i <- 1..20 do
  NewRelixApp.Repo.insert!(%NewRelixApp.User{name: "user#{i}"}) 
end
