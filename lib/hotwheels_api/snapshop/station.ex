defmodule HotwheelsApi.Snapshop.Station do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "stations" do
    field :is_installed, :boolean, default: false
    field :is_renting, :boolean, default: false
    field :is_returning, :boolean, default: false
    field :last_reported, :string
    field :legacy_id, :string
    field :num_bikes_available, :integer
    field :num_bikes_disabled, :integer
    field :num_docks_available, :integer
    field :num_docks_disabled, :integer
    field :num_ebikes_available, :integer
    field :station_status, :string

    timestamps()
  end

  @doc false
  def changeset(station, attrs) do
    station
    |> cast(attrs, [:legacy_id, :last_reported, :is_installed, :is_renting, :is_returning, :num_bikes_available, :num_ebikes_available, :num_bikes_disabled, :num_docks_available, :num_docks_disabled, :station_status])
    |> validate_required([:legacy_id, :last_reported, :is_installed, :is_renting, :is_returning, :num_bikes_available, :num_ebikes_available, :num_bikes_disabled, :num_docks_available, :num_docks_disabled, :station_status])
    |> unique_constraint(:legacy_id)
  end
end
