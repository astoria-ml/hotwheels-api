defmodule HotwheelsApi.SnapshopTest do
  use HotwheelsApi.DataCase

  alias HotwheelsApi.Snapshop

  describe "stations" do
    alias HotwheelsApi.Snapshop.Station

    import HotwheelsApi.SnapshopFixtures

    @invalid_attrs %{is_installed: nil, is_renting: nil, is_returning: nil, last_reported: nil, legacy_id: nil, num_bikes_available: nil, num_bikes_disabled: nil, num_docks_available: nil, num_docks_disabled: nil, num_ebikes_available: nil, station_status: nil}

    test "list_stations/0 returns all stations" do
      station = station_fixture()
      assert Snapshop.list_stations() == [station]
    end

    test "get_station!/1 returns the station with given id" do
      station = station_fixture()
      assert Snapshop.get_station!(station.id) == station
    end

    test "create_station/1 with valid data creates a station" do
      valid_attrs = %{is_installed: true, is_renting: true, is_returning: true, last_reported: "some last_reported", legacy_id: "some legacy_id", num_bikes_available: 42, num_bikes_disabled: 42, num_docks_available: 42, num_docks_disabled: 42, num_ebikes_available: 42, station_status: "some station_status"}

      assert {:ok, %Station{} = station} = Snapshop.create_station(valid_attrs)
      assert station.is_installed == true
      assert station.is_renting == true
      assert station.is_returning == true
      assert station.last_reported == "some last_reported"
      assert station.legacy_id == "some legacy_id"
      assert station.num_bikes_available == 42
      assert station.num_bikes_disabled == 42
      assert station.num_docks_available == 42
      assert station.num_docks_disabled == 42
      assert station.num_ebikes_available == 42
      assert station.station_status == "some station_status"
    end

    test "create_station/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Snapshop.create_station(@invalid_attrs)
    end

    test "update_station/2 with valid data updates the station" do
      station = station_fixture()
      update_attrs = %{is_installed: false, is_renting: false, is_returning: false, last_reported: "some updated last_reported", legacy_id: "some updated legacy_id", num_bikes_available: 43, num_bikes_disabled: 43, num_docks_available: 43, num_docks_disabled: 43, num_ebikes_available: 43, station_status: "some updated station_status"}

      assert {:ok, %Station{} = station} = Snapshop.update_station(station, update_attrs)
      assert station.is_installed == false
      assert station.is_renting == false
      assert station.is_returning == false
      assert station.last_reported == "some updated last_reported"
      assert station.legacy_id == "some updated legacy_id"
      assert station.num_bikes_available == 43
      assert station.num_bikes_disabled == 43
      assert station.num_docks_available == 43
      assert station.num_docks_disabled == 43
      assert station.num_ebikes_available == 43
      assert station.station_status == "some updated station_status"
    end

    test "update_station/2 with invalid data returns error changeset" do
      station = station_fixture()
      assert {:error, %Ecto.Changeset{}} = Snapshop.update_station(station, @invalid_attrs)
      assert station == Snapshop.get_station!(station.id)
    end

    test "delete_station/1 deletes the station" do
      station = station_fixture()
      assert {:ok, %Station{}} = Snapshop.delete_station(station)
      assert_raise Ecto.NoResultsError, fn -> Snapshop.get_station!(station.id) end
    end

    test "change_station/1 returns a station changeset" do
      station = station_fixture()
      assert %Ecto.Changeset{} = Snapshop.change_station(station)
    end
  end
end
