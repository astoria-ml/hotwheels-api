defmodule HotwheelsApiWeb.StationController do
  use HotwheelsApiWeb, :controller

  alias HotwheelsApi.Snapshop
  alias HotwheelsApi.Snapshop.Station

  action_fallback HotwheelsApiWeb.FallbackController

  def index(conn, _params) do
    stations = Snapshop.list_stations()
    render(conn, :index, stations: stations)
  end

  def create(conn, %{"station" => station_params}) do
    with {:ok, %Station{} = station} <- Snapshop.create_station(station_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/stations/#{station}")
      |> render(:show, station: station)
    end
  end

  def show(conn, %{"id" => id}) do
    station = Snapshop.get_station!(id)
    render(conn, :show, station: station)
  end

  def update(conn, %{"id" => id, "station" => station_params}) do
    station = Snapshop.get_station!(id)

    with {:ok, %Station{} = station} <- Snapshop.update_station(station, station_params) do
      render(conn, :show, station: station)
    end
  end

  def delete(conn, %{"id" => id}) do
    station = Snapshop.get_station!(id)

    with {:ok, %Station{}} <- Snapshop.delete_station(station) do
      send_resp(conn, :no_content, "")
    end
  end
end
