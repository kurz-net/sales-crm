defmodule Dashboard.AccountsTest do
  use Dashboard.DataCase

  alias Dashboard.Accounts

  describe "email" do
    alias Dashboard.Accounts.User

    @valid_attrs %{password: "some password", role: "some role"}
    @update_attrs %{password: "some updated password", role: "some updated role"}
    @invalid_attrs %{password: nil, role: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_user()

      user
    end

    test "list_email/0 returns all email" do
      user = user_fixture()
      assert Accounts.list_email() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Accounts.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Accounts.create_user(@valid_attrs)
      assert user.password == "some password"
      assert user.role == "some role"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, %User{} = user} = Accounts.update_user(user, @update_attrs)
      assert user.password == "some updated password"
      assert user.role == "some updated role"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_attrs)
      assert user == Accounts.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Accounts.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Accounts.change_user(user)
    end
  end

  describe "activation_codes" do
    alias Dashboard.Accounts.ActivationCode

    @valid_attrs %{code: "some code"}
    @update_attrs %{code: "some updated code"}
    @invalid_attrs %{code: nil}

    def activation_code_fixture(attrs \\ %{}) do
      {:ok, activation_code} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_activation_code()

      activation_code
    end

    test "list_activation_codes/0 returns all activation_codes" do
      activation_code = activation_code_fixture()
      assert Accounts.list_activation_codes() == [activation_code]
    end

    test "get_activation_code!/1 returns the activation_code with given id" do
      activation_code = activation_code_fixture()
      assert Accounts.get_activation_code!(activation_code.id) == activation_code
    end

    test "create_activation_code/1 with valid data creates a activation_code" do
      assert {:ok, %ActivationCode{} = activation_code} = Accounts.create_activation_code(@valid_attrs)
      assert activation_code.code == "some code"
    end

    test "create_activation_code/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_activation_code(@invalid_attrs)
    end

    test "update_activation_code/2 with valid data updates the activation_code" do
      activation_code = activation_code_fixture()
      assert {:ok, %ActivationCode{} = activation_code} = Accounts.update_activation_code(activation_code, @update_attrs)
      assert activation_code.code == "some updated code"
    end

    test "update_activation_code/2 with invalid data returns error changeset" do
      activation_code = activation_code_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_activation_code(activation_code, @invalid_attrs)
      assert activation_code == Accounts.get_activation_code!(activation_code.id)
    end

    test "delete_activation_code/1 deletes the activation_code" do
      activation_code = activation_code_fixture()
      assert {:ok, %ActivationCode{}} = Accounts.delete_activation_code(activation_code)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_activation_code!(activation_code.id) end
    end

    test "change_activation_code/1 returns a activation_code changeset" do
      activation_code = activation_code_fixture()
      assert %Ecto.Changeset{} = Accounts.change_activation_code(activation_code)
    end
  end
end
