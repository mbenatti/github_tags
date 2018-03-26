defmodule GithubTags.Repo.Migrations.CreateUserTable do
  use Ecto.Migration

  def up do
   create table(:users, primary_key: false) do
      add :username, :string, primary_key: true

      timestamps()
    end
    create index(:users, [:username])
  end

  def down do
    drop index(:users, [:username])
    drop table(:users)
  end
end
