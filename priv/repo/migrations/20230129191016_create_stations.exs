defmodule HotwheelsApi.Repo.Migrations.CreateStations do
  use Ecto.Migration

  def change do
    create table(:stations, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :legacy_id, :string
      add :last_reported, :string
      add :is_installed, :boolean, default: false, null: false
      add :is_renting, :boolean, default: false, null: false
      add :is_returning, :boolean, default: false, null: false
      add :num_bikes_available, :integer
      add :num_ebikes_available, :integer
      add :num_bikes_disabled, :integer
      add :num_docks_available, :integer
      add :num_docks_disabled, :integer
      add :station_status, :string

      timestamps()
    end

    create unique_index(:stations, [:legacy_id])
  end
end
