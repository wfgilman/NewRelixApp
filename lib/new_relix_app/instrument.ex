defmodule NewRelixApp.Instrument do
  use NewRelix.Instrumenter

  # Phoenix instrumentation callbacks.
  def render_view(:start, _compile_metadata, %{view: name}) do
    "Web/#{name}[ms|render]"
  end
  def render_view(:stop, time_diff, label) do
    NewRelix.Collector.record_value(label, time_diff / 1_000_000)
  end

  # Ecto instrumentation override.
  def log_entry(%{query_time: time, result: {:ok, %{command: command}}}) do
    str_command = command |> to_string() |> String.upcase()
    label = "Database/#{to_string(str_command)}[ms|query]"
    NewRelix.Collector.record_value(label, time / 1_000_000)
  end
end
