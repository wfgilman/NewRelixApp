# NewRelixApp

Sample application illustrating how [NewRelix](https://github.com/wfgilman/NewRelix) can be utilized.

## Installation

Clone this repository locally. Get and install dependencies then setup the database
and start the server. You will be able to see the recorded metrics under the
Plugins section of your New Relic account.

```
cd new_relix_app
mix deps.get
mix ecto.setup

iex -S mix phoenix.server
```

## Configuration

Three configurations are made to use NewRelix. First `:instrumenters` is added to
the Phoenix Endpoint config.
```elixir
config :new_relix_app, NewRelixApp.Endpoint,
  instrumenters: [NewRelixApp.Instrument]
```

Second, `:loggers` is added to the Ecto Repo config.
```elixir
config :new_relix_app, NewRelixApp.Repo,
  loggers: [{Ecto.LogEntry, :log, []}, {NewRelixApp.Instrument, :log_entry, []}]
```

Third, the NewRelix config is added.
```elixir
config :new_relix,
  license_key: System.get_env("NEW_RELIC_LICENSE_KEY"),
  plugin_guid: "com.mycompany.elixir",
  application_name: "NewRelixApp"
```

## Instrumentation Examples

### Generic

`NewRelixApp.UserController.index/2` demonstrates how `measure/2` is used by
wrapping `Repo.all/2`:
```elixir
def index(conn, _params) do
  users = NewRelixApp.Instrument.measure({Repo, :all, [NewRelixApp.User]})
  render conn, "index.html", users: users
end
```
<img src='http://i.imgur.com/ORAnzUo.png?1' />

### Phoenix Default Events

These events are measured automatically just by adding `NewRelixApp.Instrument`
to the `:instrumenters` key in the Endpoint config. They can be overridden in
`NewRelixApp.Instrument`.

<img src='http://i.imgur.com/3nbOBHz.png' />

### Phoenix Custom Events

`NewRelixApp.UserController.show/2` demonstrates how a custom event is instrumented
using NewRelix and Phoenix's extensible API:
```elixir
def show(conn, %{"id" => id}) do
  user = Repo.get(NewRelixApp.User, id)
  NewRelixApp.Endpoint.instrument :render_view, %{view: "ShowUser"}, fn ->
    render conn, "show.html", user: user
  end
end
```
And you must also define `render_view/3` in `NewRelixApp.Instrument`. Here is where
you can customize how you want the metric named.
```elixir
def render_view(:start, _compile_metadata, %{view: name}) do
  "Web/#{name}[ms|render]"
end
def render_view(:stop, time_diff, label) do
  NewRelix.Collector.record_value(label, time_diff / 1_000_000)
end
```
<img src='http://i.imgur.com/3b8numU.png' />

### Ecto Queries

These are measured automatically when `:loggers` is added to the Repo config.
The label can be modified by overriding the `log_entry/1` function in
`NewRelixApp.Instrument` to include more information.
```elixir
def log_entry(%{query_time: time, result: {:ok, %{command: command}}}) do
  str_command = command |> to_string() |> String.upcase()
  label = "Database/#{to_string(str_command)}[ms|query]"
  NewRelix.Collector.record_value(label, time / 1_000_000)
end
```
<img src='http://i.imgur.com/aAzczAt.png' />

## More information

See the NewRelix library [here](https://github.com/wfgilman/NewRelix).
