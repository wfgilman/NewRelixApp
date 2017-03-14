defmodule NewRelixApp.UserController do
  use NewRelixApp.Web, :controller
  require NewRelixApp.Endpoint

  # Instrumenting a specific function generically.
  def index(conn, _params) do
    users = NewRelixApp.Instrument.measure({Repo, :all, [NewRelixApp.User]})
    render conn, "index.html", users: users
  end

  # Instrumenting a Phoenix view using the extensible API.
  def show(conn, %{"id" => id}) do
    user = Repo.get(NewRelixApp.User, id)
    NewRelixApp.Endpoint.instrument :render_view, %{view: "ShowUser"}, fn ->
      render conn, "show.html", user: user
    end
  end
end
