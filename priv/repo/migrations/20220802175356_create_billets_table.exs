defmodule BilletManager.Repo.Migrations.CreateBilletsTable do
  use Ecto.Migration

  def change do
    create table(:billets) do
      add :code, :string, null: false
      add :value, :integer, null: false
      add :status, :string, null: false
      add :expire_on, :naive_datetime, null: false

      add :customer_id, references(:customers), null: false

      timestamps()
    end

    create unique_index(:billets, [:code])
    create index(:billets, [:status])
  end
end
