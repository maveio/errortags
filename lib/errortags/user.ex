defmodule Errortags.User do
  use Ecto.Schema
  import Ecto.Changeset

  @empty_message "seems to be empty 👀"
  @invalid_email_message "doesn't seem right 👀"
  @already_registered_message "already registered? 👀"

  schema "users" do
    field :name, :string
    field :email, :string
    timestamps()
  end

  def registration_changeset(user, attrs \\ %{}) do
    user
    |> cast(attrs, [:name, :email])
    |> validate_required([:name, :email], message: @empty_message)
    |> validate_length(:email, max: 160)
    |> validate_email()
  end

  def validate_email(changeset) do
    changeset
    |> validate_format(:email, ~r/^[^\s]+@[^\s]+$/, message: @invalid_email_message)
    |> validate_length(:email, max: 160, message: @invalid_email_message)
    |> unique_constraint(:email, message: @already_registered_message)
  end
end
