defmodule NewRelixApp.PageController do
  use NewRelixApp.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
