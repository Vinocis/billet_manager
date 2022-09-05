defmodule BilletManager.Repo.Migrations.ModifyNaiveDatetimeToDateInBillet do
  use Ecto.Migration

  def up do
    alter table(:billets) do
      modify :expire_on, :date
    end
  end

  def down do
    alter table(:billets) do
      modify :expire_on, :naive_datetime
    end
  end
end
