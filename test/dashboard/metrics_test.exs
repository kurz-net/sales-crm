defmodule Dashboard.MetricsTest do
  use Dashboard.DataCase

  alias Dashboard.Metrics

  describe "rebel_work_quotas" do
    alias Dashboard.Metrics.RebelWorkQuota

    @valid_attrs %{from_date: ~D[2010-04-17], hours: 120.5, to_date: ~D[2010-04-17]}
    @update_attrs %{from_date: ~D[2011-05-18], hours: 456.7, to_date: ~D[2011-05-18]}
    @invalid_attrs %{from_date: nil, hours: nil, to_date: nil}

    def rebel_work_quota_fixture(attrs \\ %{}) do
      {:ok, rebel_work_quota} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Metrics.create_rebel_work_quota()

      rebel_work_quota
    end

    test "list_rebel_work_quotas/0 returns all rebel_work_quotas" do
      rebel_work_quota = rebel_work_quota_fixture()
      assert Metrics.list_rebel_work_quotas() == [rebel_work_quota]
    end

    test "get_rebel_work_quota!/1 returns the rebel_work_quota with given id" do
      rebel_work_quota = rebel_work_quota_fixture()
      assert Metrics.get_rebel_work_quota!(rebel_work_quota.id) == rebel_work_quota
    end

    test "create_rebel_work_quota/1 with valid data creates a rebel_work_quota" do
      assert {:ok, %RebelWorkQuota{} = rebel_work_quota} = Metrics.create_rebel_work_quota(@valid_attrs)
      assert rebel_work_quota.from_date == ~D[2010-04-17]
      assert rebel_work_quota.hours == 120.5
      assert rebel_work_quota.to_date == ~D[2010-04-17]
    end

    test "create_rebel_work_quota/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Metrics.create_rebel_work_quota(@invalid_attrs)
    end

    test "update_rebel_work_quota/2 with valid data updates the rebel_work_quota" do
      rebel_work_quota = rebel_work_quota_fixture()
      assert {:ok, %RebelWorkQuota{} = rebel_work_quota} = Metrics.update_rebel_work_quota(rebel_work_quota, @update_attrs)
      assert rebel_work_quota.from_date == ~D[2011-05-18]
      assert rebel_work_quota.hours == 456.7
      assert rebel_work_quota.to_date == ~D[2011-05-18]
    end

    test "update_rebel_work_quota/2 with invalid data returns error changeset" do
      rebel_work_quota = rebel_work_quota_fixture()
      assert {:error, %Ecto.Changeset{}} = Metrics.update_rebel_work_quota(rebel_work_quota, @invalid_attrs)
      assert rebel_work_quota == Metrics.get_rebel_work_quota!(rebel_work_quota.id)
    end

    test "delete_rebel_work_quota/1 deletes the rebel_work_quota" do
      rebel_work_quota = rebel_work_quota_fixture()
      assert {:ok, %RebelWorkQuota{}} = Metrics.delete_rebel_work_quota(rebel_work_quota)
      assert_raise Ecto.NoResultsError, fn -> Metrics.get_rebel_work_quota!(rebel_work_quota.id) end
    end

    test "change_rebel_work_quota/1 returns a rebel_work_quota changeset" do
      rebel_work_quota = rebel_work_quota_fixture()
      assert %Ecto.Changeset{} = Metrics.change_rebel_work_quota(rebel_work_quota)
    end
  end
end
