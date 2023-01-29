defmodule HotwheelsApi.SnapshopFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `HotwheelsApi.Snapshop` context.
  """

  @doc """
  Generate a unique station legacy_id.
  """
  def unique_station_legacy_id, do: "some legacy_id#{System.unique_integer([:positive])}"

  @doc """
  Generate a station.
  """
  def station_fixture(attrs \\ %{}) do
    {:ok, station} =
      attrs
      |> Enum.into(%{
        is_installed: true,
        is_renting: true,
        is_returning: true,
        last_reported: "some last_reported",
        legacy_id: unique_station_legacy_id(),
        num_bikes_available: 42,
        num_bikes_disabled: 42,
        num_docks_available: 42,
        num_docks_disabled: 42,
        num_ebikes_available: 42,
        station_status: "some station_status"
      })
      |> HotwheelsApi.Snapshop.create_station()

    station
  end
end
