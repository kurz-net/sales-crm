defmodule Dashboard.EntitiesTest do
  use Dashboard.DataCase

  alias Dashboard.Entities

  describe "rebels" do
    alias Dashboard.Entities.Rebel

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def rebel_fixture(attrs \\ %{}) do
      {:ok, rebel} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Entities.create_rebel()

      rebel
    end

    test "list_rebels/0 returns all rebels" do
      rebel = rebel_fixture()
      assert Entities.list_rebels() == [rebel]
    end

    test "get_rebel!/1 returns the rebel with given id" do
      rebel = rebel_fixture()
      assert Entities.get_rebel!(rebel.id) == rebel
    end

    test "create_rebel/1 with valid data creates a rebel" do
      assert {:ok, %Rebel{} = rebel} = Entities.create_rebel(@valid_attrs)
      assert rebel.name == "some name"
    end

    test "create_rebel/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Entities.create_rebel(@invalid_attrs)
    end

    test "update_rebel/2 with valid data updates the rebel" do
      rebel = rebel_fixture()
      assert {:ok, %Rebel{} = rebel} = Entities.update_rebel(rebel, @update_attrs)
      assert rebel.name == "some updated name"
    end

    test "update_rebel/2 with invalid data returns error changeset" do
      rebel = rebel_fixture()
      assert {:error, %Ecto.Changeset{}} = Entities.update_rebel(rebel, @invalid_attrs)
      assert rebel == Entities.get_rebel!(rebel.id)
    end

    test "delete_rebel/1 deletes the rebel" do
      rebel = rebel_fixture()
      assert {:ok, %Rebel{}} = Entities.delete_rebel(rebel)
      assert_raise Ecto.NoResultsError, fn -> Entities.get_rebel!(rebel.id) end
    end

    test "change_rebel/1 returns a rebel changeset" do
      rebel = rebel_fixture()
      assert %Ecto.Changeset{} = Entities.change_rebel(rebel)
    end
  end

  describe "partners" do
    alias Dashboard.Entities.Partner

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def partner_fixture(attrs \\ %{}) do
      {:ok, partner} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Entities.create_partner()

      partner
    end

    test "list_partners/0 returns all partners" do
      partner = partner_fixture()
      assert Entities.list_partners() == [partner]
    end

    test "get_partner!/1 returns the partner with given id" do
      partner = partner_fixture()
      assert Entities.get_partner!(partner.id) == partner
    end

    test "create_partner/1 with valid data creates a partner" do
      assert {:ok, %Partner{} = partner} = Entities.create_partner(@valid_attrs)
      assert partner.name == "some name"
    end

    test "create_partner/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Entities.create_partner(@invalid_attrs)
    end

    test "update_partner/2 with valid data updates the partner" do
      partner = partner_fixture()
      assert {:ok, %Partner{} = partner} = Entities.update_partner(partner, @update_attrs)
      assert partner.name == "some updated name"
    end

    test "update_partner/2 with invalid data returns error changeset" do
      partner = partner_fixture()
      assert {:error, %Ecto.Changeset{}} = Entities.update_partner(partner, @invalid_attrs)
      assert partner == Entities.get_partner!(partner.id)
    end

    test "delete_partner/1 deletes the partner" do
      partner = partner_fixture()
      assert {:ok, %Partner{}} = Entities.delete_partner(partner)
      assert_raise Ecto.NoResultsError, fn -> Entities.get_partner!(partner.id) end
    end

    test "change_partner/1 returns a partner changeset" do
      partner = partner_fixture()
      assert %Ecto.Changeset{} = Entities.change_partner(partner)
    end
  end

  describe "projects" do
    alias Dashboard.Entities.Project

    @valid_attrs %{end_date: ~N[2010-04-17 14:00:00], name: "some name", start_date: ~N[2010-04-17 14:00:00]}
    @update_attrs %{end_date: ~N[2011-05-18 15:01:01], name: "some updated name", start_date: ~N[2011-05-18 15:01:01]}
    @invalid_attrs %{end_date: nil, name: nil, start_date: nil}

    def project_fixture(attrs \\ %{}) do
      {:ok, project} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Entities.create_project()

      project
    end

    test "list_projects/0 returns all projects" do
      project = project_fixture()
      assert Entities.list_projects() == [project]
    end

    test "get_project!/1 returns the project with given id" do
      project = project_fixture()
      assert Entities.get_project!(project.id) == project
    end

    test "create_project/1 with valid data creates a project" do
      assert {:ok, %Project{} = project} = Entities.create_project(@valid_attrs)
      assert project.end_date == ~N[2010-04-17 14:00:00]
      assert project.name == "some name"
      assert project.start_date == ~N[2010-04-17 14:00:00]
    end

    test "create_project/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Entities.create_project(@invalid_attrs)
    end

    test "update_project/2 with valid data updates the project" do
      project = project_fixture()
      assert {:ok, %Project{} = project} = Entities.update_project(project, @update_attrs)
      assert project.end_date == ~N[2011-05-18 15:01:01]
      assert project.name == "some updated name"
      assert project.start_date == ~N[2011-05-18 15:01:01]
    end

    test "update_project/2 with invalid data returns error changeset" do
      project = project_fixture()
      assert {:error, %Ecto.Changeset{}} = Entities.update_project(project, @invalid_attrs)
      assert project == Entities.get_project!(project.id)
    end

    test "delete_project/1 deletes the project" do
      project = project_fixture()
      assert {:ok, %Project{}} = Entities.delete_project(project)
      assert_raise Ecto.NoResultsError, fn -> Entities.get_project!(project.id) end
    end

    test "change_project/1 returns a project changeset" do
      project = project_fixture()
      assert %Ecto.Changeset{} = Entities.change_project(project)
    end
  end

  describe "leads" do
    alias Dashboard.Entities.Lead

    @valid_attrs %{company_name: "some company_name", contact_name: "some contact_name", notes: "some notes"}
    @update_attrs %{company_name: "some updated company_name", contact_name: "some updated contact_name", notes: "some updated notes"}
    @invalid_attrs %{company_name: nil, contact_name: nil, notes: nil}

    def lead_fixture(attrs \\ %{}) do
      {:ok, lead} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Entities.create_lead()

      lead
    end

    test "list_leads/0 returns all leads" do
      lead = lead_fixture()
      assert Entities.list_leads() == [lead]
    end

    test "get_lead!/1 returns the lead with given id" do
      lead = lead_fixture()
      assert Entities.get_lead!(lead.id) == lead
    end

    test "create_lead/1 with valid data creates a lead" do
      assert {:ok, %Lead{} = lead} = Entities.create_lead(@valid_attrs)
      assert lead.company_name == "some company_name"
      assert lead.contact_name == "some contact_name"
      assert lead.notes == "some notes"
    end

    test "create_lead/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Entities.create_lead(@invalid_attrs)
    end

    test "update_lead/2 with valid data updates the lead" do
      lead = lead_fixture()
      assert {:ok, %Lead{} = lead} = Entities.update_lead(lead, @update_attrs)
      assert lead.company_name == "some updated company_name"
      assert lead.contact_name == "some updated contact_name"
      assert lead.notes == "some updated notes"
    end

    test "update_lead/2 with invalid data returns error changeset" do
      lead = lead_fixture()
      assert {:error, %Ecto.Changeset{}} = Entities.update_lead(lead, @invalid_attrs)
      assert lead == Entities.get_lead!(lead.id)
    end

    test "delete_lead/1 deletes the lead" do
      lead = lead_fixture()
      assert {:ok, %Lead{}} = Entities.delete_lead(lead)
      assert_raise Ecto.NoResultsError, fn -> Entities.get_lead!(lead.id) end
    end

    test "change_lead/1 returns a lead changeset" do
      lead = lead_fixture()
      assert %Ecto.Changeset{} = Entities.change_lead(lead)
    end
  end
end
