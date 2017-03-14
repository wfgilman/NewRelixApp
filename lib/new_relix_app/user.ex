defmodule NewRelixApp.User do

   use Ecto.Schema

   schema "user" do
     field :name, :string
     timestamps() 
   end
end
