defmodule GithubTags.Repo.Migrations.CreateRepositoryTable do
  use Ecto.Migration

  def up do
    create table(:repositories) do
      add :name, :string
      add :url, :string
      add :language, :string
      add :description, :string
      add :tags, {:array, :string}
      add :user, references(:users, column: :username, type: :string)

      timestamps()
    end
    create unique_index(:repositories, [:user, :url])
  end

  def down do
    drop unique_index(:repositories, [:user, :url])
    drop table(:repositories)
  end
end
