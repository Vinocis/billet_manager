defmodule BilletManager.Repo.Migrations.CreateCustomerTable do
  use Ecto.Migration

  def change do
    create table(:customers) do
      add :name, :string, null: false
      add :cpf, :string, null: false

      timestamps()
    end

    create unique_index(:customers, [:cpf])
  end
end
