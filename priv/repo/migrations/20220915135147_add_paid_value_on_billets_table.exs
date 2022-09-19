defmodule BilletManager.Repo.Migrations.AddPaidValueOnBilletsTable do
  use Ecto.Migration

  def up do
    alter table(:billets) do
      add :paid_value, :integer
    end
  end

  def down do
    alter table(:billets) do
      remove :paid_value
    end
  end
end
