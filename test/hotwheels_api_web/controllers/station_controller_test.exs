defmodule HotwheelsApiWeb.StationControllerTest do
  use HotwheelsApiWeb.ConnCase

  import HotwheelsApi.SnapshopFixtures

  alias HotwheelsApi.Snapshop.Station

  @create_attrs %{
    is_installed: true,
    is_renting: true,
    is_returning: true,
    last_reported: "some last_reported",
    legacy_id: "some legacy_id",
    num_bikes_available: 42,
    num_bikes_disabled: 42,
    num_docks_available: 42,
    num_docks_disabled: 42,
    num_ebikes_available: 42,
    station_status: "some station_status"
  }
  @update_attrs %{
    is_installed: false,
    is_renting: false,
    is_returning: false,
    last_reported: "some updated last_reported",
    legacy_id: "some updated legacy_id",
    num_bikes_available: 43,
    num_bikes_disabled: 43,
    num_docks_available: 43,
    num_docks_disabled: 43,
    num_ebikes_available: 43,
    station_status: "some updated station_status"
  }
  @invalid_attrs %{is_installed: nil, is_renting: nil, is_returning: nil, last_reported: nil, legacy_id: nil, num_bikes_available: nil, num_bikes_disabled: nil, num_docks_available: nil, num_docks_disabled: nil, num_ebikes_available: nil, station_status: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all stations", %{conn: conn} do
      conn = get(conn, ~p"/api/stations")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create station" do
    test "renders station when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/stations", station: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/stations/#{id}")

      assert %{
               "id" => ^id,
               "is_installed" => true,
               "is_renting" => true,
               "is_returning" => true,
               "last_reported" => "some last_reported",
               "legacy_id" => "some legacy_id",
               "num_bikes_available" => 42,
               "num_bikes_disabled" => 42,
               "num_docks_available" => 42,
               "num_docks_disabled" => 42,
               "num_ebikes_available" => 42,
               "station_status" => "some station_status"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/stations", station: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update station" do
    setup [:create_station]

    test "renders station when data is valid", %{conn: conn, station: %Station{id: id} = station} do
      conn = put(conn, ~p"/api/stations/#{station}", station: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/stations/#{id}")

      assert %{
               "id" => ^id,
               "is_installed" => false,
               "is_renting" => false,
               "is_returning" => false,
               "last_reported" => "some updated last_reported",
               "legacy_id" => "some updated legacy_id",
               "num_bikes_available" => 43,
               "num_bikes_disabled" => 43,
               "num_docks_available" => 43,
               "num_docks_disabled" => 43,
               "num_ebikes_available" => 43,
               "station_status" => "some updated station_status"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, station: station} do
      conn = put(conn, ~p"/api/stations/#{station}", station: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete station" do
    setup [:create_station]

    test "deletes chosen station", %{conn: conn, station: station} do
      conn = delete(conn, ~p"/api/stations/#{station}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/stations/#{station}")
      end
    end
  end

  defp create_station(_) do
    station = station_fixture()
    %{station: station}
  end
end
