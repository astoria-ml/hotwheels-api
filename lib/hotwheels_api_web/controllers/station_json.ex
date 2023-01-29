defmodule HotwheelsApiWeb.StationJSON do
  alias HotwheelsApi.Snapshop.Station

  @doc """
  Renders a list of stations.
  """
  def index(%{stations: stations}) do
    %{data: for(station <- stations, do: data(station))}
  end

  @doc """
  Renders a single station.
  """
  def show(%{station: station}) do
    %{data: data(station)}
  end

  defp data(%Station{} = station) do
    %{
      id: station.id,
      legacy_id: station.legacy_id,
      last_reported: station.last_reported,
      is_installed: station.is_installed,
      is_renting: station.is_renting,
      is_returning: station.is_returning,
      num_bikes_available: station.num_bikes_available,
      num_ebikes_available: station.num_ebikes_available,
      num_bikes_disabled: station.num_bikes_disabled,
      num_docks_available: station.num_docks_available,
      num_docks_disabled: station.num_docks_disabled,
      station_status: station.station_status
    }
  end
end
