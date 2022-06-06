defmodule Dashboard.SalesTest do
  use Dashboard.DataCase

  alias Dashboard.Sales

  describe "calls" do
    alias Dashboard.Sales.Call

    @valid_attrs %{contact_name: "some contact_name", follow_up: ~N[2010-04-17 14:00:00], length: 42, outcome: "some outcome"}
    @update_attrs %{contact_name: "some updated contact_name", follow_up: ~N[2011-05-18 15:01:01], length: 43, outcome: "some updated outcome"}
    @invalid_attrs %{contact_name: nil, follow_up: nil, length: nil, outcome: nil}

    def call_fixture(attrs \\ %{}) do
      {:ok, call} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Sales.create_call()

      call
    end

    test "list_calls/0 returns all calls" do
      call = call_fixture()
      assert Sales.list_calls() == [call]
    end

    test "get_call!/1 returns the call with given id" do
      call = call_fixture()
      assert Sales.get_call!(call.id) == call
    end

    test "create_call/1 with valid data creates a call" do
      assert {:ok, %Call{} = call} = Sales.create_call(@valid_attrs)
      assert call.contact_name == "some contact_name"
      assert call.follow_up == ~N[2010-04-17 14:00:00]
      assert call.length == 42
      assert call.outcome == "some outcome"
    end

    test "create_call/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Sales.create_call(@invalid_attrs)
    end

    test "update_call/2 with valid data updates the call" do
      call = call_fixture()
      assert {:ok, %Call{} = call} = Sales.update_call(call, @update_attrs)
      assert call.contact_name == "some updated contact_name"
      assert call.follow_up == ~N[2011-05-18 15:01:01]
      assert call.length == 43
      assert call.outcome == "some updated outcome"
    end

    test "update_call/2 with invalid data returns error changeset" do
      call = call_fixture()
      assert {:error, %Ecto.Changeset{}} = Sales.update_call(call, @invalid_attrs)
      assert call == Sales.get_call!(call.id)
    end

    test "delete_call/1 deletes the call" do
      call = call_fixture()
      assert {:ok, %Call{}} = Sales.delete_call(call)
      assert_raise Ecto.NoResultsError, fn -> Sales.get_call!(call.id) end
    end

    test "change_call/1 returns a call changeset" do
      call = call_fixture()
      assert %Ecto.Changeset{} = Sales.change_call(call)
    end
  end

  describe "sessions" do
    alias Dashboard.Sales.Session

    @valid_attrs %{start: ~N[2010-04-17 14:00:00]}
    @update_attrs %{start: ~N[2011-05-18 15:01:01]}
    @invalid_attrs %{start: nil}

    def session_fixture(attrs \\ %{}) do
      {:ok, session} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Sales.create_session()

      session
    end

    test "list_sessions/0 returns all sessions" do
      session = session_fixture()
      assert Sales.list_sessions() == [session]
    end

    test "get_session!/1 returns the session with given id" do
      session = session_fixture()
      assert Sales.get_session!(session.id) == session
    end

    test "create_session/1 with valid data creates a session" do
      assert {:ok, %Session{} = session} = Sales.create_session(@valid_attrs)
      assert session.start == ~N[2010-04-17 14:00:00]
    end

    test "create_session/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Sales.create_session(@invalid_attrs)
    end

    test "update_session/2 with valid data updates the session" do
      session = session_fixture()
      assert {:ok, %Session{} = session} = Sales.update_session(session, @update_attrs)
      assert session.start == ~N[2011-05-18 15:01:01]
    end

    test "update_session/2 with invalid data returns error changeset" do
      session = session_fixture()
      assert {:error, %Ecto.Changeset{}} = Sales.update_session(session, @invalid_attrs)
      assert session == Sales.get_session!(session.id)
    end

    test "delete_session/1 deletes the session" do
      session = session_fixture()
      assert {:ok, %Session{}} = Sales.delete_session(session)
      assert_raise Ecto.NoResultsError, fn -> Sales.get_session!(session.id) end
    end

    test "change_session/1 returns a session changeset" do
      session = session_fixture()
      assert %Ecto.Changeset{} = Sales.change_session(session)
    end
  end

  describe "documentations" do
    alias Dashboard.Sales.Documentation

    @valid_attrs %{continuation: "some continuation", data: "some data", disc: "some disc", pains: []}
    @update_attrs %{continuation: "some updated continuation", data: "some updated data", disc: "some updated disc", pains: []}
    @invalid_attrs %{continuation: nil, data: nil, disc: nil, pains: nil}

    def documentation_fixture(attrs \\ %{}) do
      {:ok, documentation} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Sales.create_documentation()

      documentation
    end

    test "list_documentations/0 returns all documentations" do
      documentation = documentation_fixture()
      assert Sales.list_documentations() == [documentation]
    end

    test "get_documentation!/1 returns the documentation with given id" do
      documentation = documentation_fixture()
      assert Sales.get_documentation!(documentation.id) == documentation
    end

    test "create_documentation/1 with valid data creates a documentation" do
      assert {:ok, %Documentation{} = documentation} = Sales.create_documentation(@valid_attrs)
      assert documentation.continuation == "some continuation"
      assert documentation.data == "some data"
      assert documentation.disc == "some disc"
      assert documentation.pains == []
    end

    test "create_documentation/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Sales.create_documentation(@invalid_attrs)
    end

    test "update_documentation/2 with valid data updates the documentation" do
      documentation = documentation_fixture()
      assert {:ok, %Documentation{} = documentation} = Sales.update_documentation(documentation, @update_attrs)
      assert documentation.continuation == "some updated continuation"
      assert documentation.data == "some updated data"
      assert documentation.disc == "some updated disc"
      assert documentation.pains == []
    end

    test "update_documentation/2 with invalid data returns error changeset" do
      documentation = documentation_fixture()
      assert {:error, %Ecto.Changeset{}} = Sales.update_documentation(documentation, @invalid_attrs)
      assert documentation == Sales.get_documentation!(documentation.id)
    end

    test "delete_documentation/1 deletes the documentation" do
      documentation = documentation_fixture()
      assert {:ok, %Documentation{}} = Sales.delete_documentation(documentation)
      assert_raise Ecto.NoResultsError, fn -> Sales.get_documentation!(documentation.id) end
    end

    test "change_documentation/1 returns a documentation changeset" do
      documentation = documentation_fixture()
      assert %Ecto.Changeset{} = Sales.change_documentation(documentation)
    end
  end

  describe "project_rebels" do
    alias Dashboard.Sales.ProjectRebel

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def project_rebel_fixture(attrs \\ %{}) do
      {:ok, project_rebel} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Sales.create_project_rebel()

      project_rebel
    end

    test "list_project_rebels/0 returns all project_rebels" do
      project_rebel = project_rebel_fixture()
      assert Sales.list_project_rebels() == [project_rebel]
    end

    test "get_project_rebel!/1 returns the project_rebel with given id" do
      project_rebel = project_rebel_fixture()
      assert Sales.get_project_rebel!(project_rebel.id) == project_rebel
    end

    test "create_project_rebel/1 with valid data creates a project_rebel" do
      assert {:ok, %ProjectRebel{} = project_rebel} = Sales.create_project_rebel(@valid_attrs)
    end

    test "create_project_rebel/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Sales.create_project_rebel(@invalid_attrs)
    end

    test "update_project_rebel/2 with valid data updates the project_rebel" do
      project_rebel = project_rebel_fixture()
      assert {:ok, %ProjectRebel{} = project_rebel} = Sales.update_project_rebel(project_rebel, @update_attrs)
    end

    test "update_project_rebel/2 with invalid data returns error changeset" do
      project_rebel = project_rebel_fixture()
      assert {:error, %Ecto.Changeset{}} = Sales.update_project_rebel(project_rebel, @invalid_attrs)
      assert project_rebel == Sales.get_project_rebel!(project_rebel.id)
    end

    test "delete_project_rebel/1 deletes the project_rebel" do
      project_rebel = project_rebel_fixture()
      assert {:ok, %ProjectRebel{}} = Sales.delete_project_rebel(project_rebel)
      assert_raise Ecto.NoResultsError, fn -> Sales.get_project_rebel!(project_rebel.id) end
    end

    test "change_project_rebel/1 returns a project_rebel changeset" do
      project_rebel = project_rebel_fixture()
      assert %Ecto.Changeset{} = Sales.change_project_rebel(project_rebel)
    end
  end

  describe "requirements" do
    alias Dashboard.Sales.PerformanceRequirement

    @valid_attrs %{calls: 42, from_date: ~D[2010-04-17], hours: 42, to_date: ~D[2010-04-17]}
    @update_attrs %{calls: 43, from_date: ~D[2011-05-18], hours: 43, to_date: ~D[2011-05-18]}
    @invalid_attrs %{calls: nil, from_date: nil, hours: nil, to_date: nil}

    def performance_requirement_fixture(attrs \\ %{}) do
      {:ok, performance_requirement} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Sales.create_performance_requirement()

      performance_requirement
    end

    test "list_requirements/0 returns all requirements" do
      performance_requirement = performance_requirement_fixture()
      assert Sales.list_requirements() == [performance_requirement]
    end

    test "get_performance_requirement!/1 returns the performance_requirement with given id" do
      performance_requirement = performance_requirement_fixture()
      assert Sales.get_performance_requirement!(performance_requirement.id) == performance_requirement
    end

    test "create_performance_requirement/1 with valid data creates a performance_requirement" do
      assert {:ok, %PerformanceRequirement{} = performance_requirement} = Sales.create_performance_requirement(@valid_attrs)
      assert performance_requirement.calls == 42
      assert performance_requirement.from_date == ~D[2010-04-17]
      assert performance_requirement.hours == 42
      assert performance_requirement.to_date == ~D[2010-04-17]
    end

    test "create_performance_requirement/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Sales.create_performance_requirement(@invalid_attrs)
    end

    test "update_performance_requirement/2 with valid data updates the performance_requirement" do
      performance_requirement = performance_requirement_fixture()
      assert {:ok, %PerformanceRequirement{} = performance_requirement} = Sales.update_performance_requirement(performance_requirement, @update_attrs)
      assert performance_requirement.calls == 43
      assert performance_requirement.from_date == ~D[2011-05-18]
      assert performance_requirement.hours == 43
      assert performance_requirement.to_date == ~D[2011-05-18]
    end

    test "update_performance_requirement/2 with invalid data returns error changeset" do
      performance_requirement = performance_requirement_fixture()
      assert {:error, %Ecto.Changeset{}} = Sales.update_performance_requirement(performance_requirement, @invalid_attrs)
      assert performance_requirement == Sales.get_performance_requirement!(performance_requirement.id)
    end

    test "delete_performance_requirement/1 deletes the performance_requirement" do
      performance_requirement = performance_requirement_fixture()
      assert {:ok, %PerformanceRequirement{}} = Sales.delete_performance_requirement(performance_requirement)
      assert_raise Ecto.NoResultsError, fn -> Sales.get_performance_requirement!(performance_requirement.id) end
    end

    test "change_performance_requirement/1 returns a performance_requirement changeset" do
      performance_requirement = performance_requirement_fixture()
      assert %Ecto.Changeset{} = Sales.change_performance_requirement(performance_requirement)
    end
  end
end
