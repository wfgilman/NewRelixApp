defmodule NewRelixApp.UserView do
  use NewRelixApp.Web, :view
  alias NewRelixApp.User

  def name(%User{name: name}) do
    name 
  end
end
