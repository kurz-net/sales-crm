defmodule Dashboard.FinanceTest do
  use Dashboard.DataCase

  alias Dashboard.Finance

  describe "packets" do
    alias Dashboard.Finance.Packet

    @valid_attrs %{description: "some description", name: "some name"}
    @update_attrs %{description: "some updated description", name: "some updated name"}
    @invalid_attrs %{description: nil, name: nil}

    def packet_fixture(attrs \\ %{}) do
      {:ok, packet} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Finance.create_packet()

      packet
    end

    test "list_packets/0 returns all packets" do
      packet = packet_fixture()
      assert Finance.list_packets() == [packet]
    end

    test "get_packet!/1 returns the packet with given id" do
      packet = packet_fixture()
      assert Finance.get_packet!(packet.id) == packet
    end

    test "create_packet/1 with valid data creates a packet" do
      assert {:ok, %Packet{} = packet} = Finance.create_packet(@valid_attrs)
      assert packet.description == "some description"
      assert packet.name == "some name"
    end

    test "create_packet/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Finance.create_packet(@invalid_attrs)
    end

    test "update_packet/2 with valid data updates the packet" do
      packet = packet_fixture()
      assert {:ok, %Packet{} = packet} = Finance.update_packet(packet, @update_attrs)
      assert packet.description == "some updated description"
      assert packet.name == "some updated name"
    end

    test "update_packet/2 with invalid data returns error changeset" do
      packet = packet_fixture()
      assert {:error, %Ecto.Changeset{}} = Finance.update_packet(packet, @invalid_attrs)
      assert packet == Finance.get_packet!(packet.id)
    end

    test "delete_packet/1 deletes the packet" do
      packet = packet_fixture()
      assert {:ok, %Packet{}} = Finance.delete_packet(packet)
      assert_raise Ecto.NoResultsError, fn -> Finance.get_packet!(packet.id) end
    end

    test "change_packet/1 returns a packet changeset" do
      packet = packet_fixture()
      assert %Ecto.Changeset{} = Finance.change_packet(packet)
    end
  end

  describe "rebel_credits" do
    alias Dashboard.Finance.RebelCredit

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def rebel_credit_fixture(attrs \\ %{}) do
      {:ok, rebel_credit} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Finance.create_rebel_credit()

      rebel_credit
    end

    test "list_rebel_credits/0 returns all rebel_credits" do
      rebel_credit = rebel_credit_fixture()
      assert Finance.list_rebel_credits() == [rebel_credit]
    end

    test "get_rebel_credit!/1 returns the rebel_credit with given id" do
      rebel_credit = rebel_credit_fixture()
      assert Finance.get_rebel_credit!(rebel_credit.id) == rebel_credit
    end

    test "create_rebel_credit/1 with valid data creates a rebel_credit" do
      assert {:ok, %RebelCredit{} = rebel_credit} = Finance.create_rebel_credit(@valid_attrs)
    end

    test "create_rebel_credit/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Finance.create_rebel_credit(@invalid_attrs)
    end

    test "update_rebel_credit/2 with valid data updates the rebel_credit" do
      rebel_credit = rebel_credit_fixture()
      assert {:ok, %RebelCredit{} = rebel_credit} = Finance.update_rebel_credit(rebel_credit, @update_attrs)
    end

    test "update_rebel_credit/2 with invalid data returns error changeset" do
      rebel_credit = rebel_credit_fixture()
      assert {:error, %Ecto.Changeset{}} = Finance.update_rebel_credit(rebel_credit, @invalid_attrs)
      assert rebel_credit == Finance.get_rebel_credit!(rebel_credit.id)
    end

    test "delete_rebel_credit/1 deletes the rebel_credit" do
      rebel_credit = rebel_credit_fixture()
      assert {:ok, %RebelCredit{}} = Finance.delete_rebel_credit(rebel_credit)
      assert_raise Ecto.NoResultsError, fn -> Finance.get_rebel_credit!(rebel_credit.id) end
    end

    test "change_rebel_credit/1 returns a rebel_credit changeset" do
      rebel_credit = rebel_credit_fixture()
      assert %Ecto.Changeset{} = Finance.change_rebel_credit(rebel_credit)
    end
  end
end
