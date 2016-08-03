defmodule Bank.Customer do
  use Bank.Model

  schema "bank_customers" do
    field :username, :string
    field :email, :string
    field :auth_account_id, :integer

    belongs_to :wallet, Ledger.Account

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, ~w(username)a)
    |> validate_required(~w(username)a)
    |> unique_constraint(:username)
  end

  def build(%{username: username}) do
    changeset(%Customer{}, %{username: username})
    |> put_assoc(:wallet, Ledger.Account.build_wallet("Wallet: #{username}"))
  end
end
