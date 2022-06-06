alias Dashboard.Repo
alias Dashboard.{Entities, Sales, Finance, Accounts, Metrics}
alias Dashboard.Entities.{Partner, Rebel, Project, Lead}
alias Dashboard.Sales.{Call, Session, Documentation, ProjectRebel, PerformanceRequirement}
alias Dashboard.Finance.{Packet, RebelCredit}
alias Dashboard.Metrics.RebelWorkQuota
alias Dashboard.Accounts.User

defmodule Seed do
  def clear_db do
    [
      Entities.list_leads,
      Sales.list_requirements,
      Accounts.list_users,
      Sales.list_documentations,
      Sales.list_sessions,
      Metrics.list_rebel_work_quotas,
      Finance.list_rebel_credits,
      Sales.list_calls,
      Finance.list_packets,
      Sales.list_project_rebels,
      Entities.list_projects,
      Entities.list_partners,
      Entities.list_rebels
    ]
    |> Enum.each(fn data ->
      Enum.each(data, &Repo.delete/1)
    end)
  end

  defp seed_db(file_path, headers, transformers, struct) do
    data = File.stream!(file_path)
    |> CSV.decode!(headers: headers)
    |> Enum.drop(1) # Headers

    data = Enum.map(data, fn row ->
      transformed =
        Enum.map(transformers, fn [prop, func] ->
          prop_value = case Map.fetch!(row, prop) do
           "" -> nil
           value -> func.(value)
          end
          {prop, prop_value}
        end)
        |> Enum.into(%{})
      Map.merge(row, transformed)
    end)

    Enum.each(data, fn row ->
      Map.merge(struct, row)
      |> Repo.insert!
    end)
  end

  def seed_rebels do
    seed_db(
      "./priv/repo/seed/rebels.csv",
      [:id, :first_name, :last_name],
      [
        [:id, &parse_int/1]
      ],
      %Rebel{}
    )
  end

  def seed_sessions do
    seed_db(
      "./priv/repo/seed/sessions.csv",
      [:id, :rebel_id, :end],
      [
        [:id, &parse_int/1],
        [:rebel_id, &parse_int/1],
        [:end, &parse_datetime/1]
      ],
      %Session{}
    )
  end

  def seed_partners do
    seed_db(
      "./priv/repo/seed/partners.csv",
      [:id, :name],
      [
        [:id, &parse_int/1]
      ],
      %Partner{}
    )
  end

  def seed_projects do
    seed_db(
      "./priv/repo/seed/projects.csv",
      [:id, :name, :partner_id, :start_date, :end_date],
      [
        [:id, &parse_int/1],
        [:partner_id, &parse_int/1],
        [:start_date, &parse_datetime/1],
        [:end_date, &parse_datetime/1]
      ],
      %Project{}
    )
  end

  def seed_calls do
    seed_db(
      "./priv/repo/seed/calls.csv",
      [:id, :contact_name, :length, :outcome, :follow_up, :lead_id],
      [
        [:id, &parse_int/1],
        [:length, &parse_int/1],
        [:follow_up, &parse_datetime/1],
        [:lead_id, &parse_int/1]
      ],
      %Call{}
    )
  end

  def seed_documentations do
    seed_db(
      "./priv/repo/seed/documentations.csv",
      [:id, :disc, :branche, :pains, :other, :call_id, :data],
      [
        [:id, &parse_int/1],
        [:call_id, &parse_int/1]
      ],
      %Documentation{}
    )
  end

  def seed_project_rebels do
    seed_db(
      "./priv/repo/seed/project_rebels.csv",
      [:id, :project_id, :rebel_id],
      [
        [:id, &parse_int/1],
        [:project_id, &parse_int/1],
        [:rebel_id, &parse_int/1],
      ],
      %ProjectRebel{}
    )
  end

  """
  def seed_packets do
    seed_db(
      "./priv/repo/seed/packets.csv",
      [:id, :project_id, :name, :description, :commission, :cost],
      [
        [:id, &parse_int/1],
        [:project_id, &parse_int/1],
        [:commisson, &parse_map/1],
        [:cost, &parse_map/1]
      ],
      %Packet{}
    )
  end
  """
  def seed_packets do
    %Packet{
      id: 0,
      project_id: 0,
      name: "Basic",
      description: "A very basic packet",
      commission: %{
        percentage: true,
        value: 5.0
      },
      cost: 100.0
    }
    |> Repo.insert!

    %Packet{
      id: 1,
      project_id: 0,
      name: "Premium",
      description: "A very premium packet",
      commission: %{
        percentage: false,
        value: 50.0
      },
      cost: 850.0
    }
    |> Repo.insert!
  end

  def seed_users do
    seed_db(
      "./priv/repo/seed/users.csv",
      [:id, :email, :password, :role, :rebel_id, :partner_id],
      [
        [:id, &parse_int/1],
        [:rebel_id, &parse_int/1],
        [:partner_id, &parse_int/1],
      ],
      %User{}
    )
  end

  def seed_rebel_credits do
    seed_db(
      "./priv/repo/seed/rebel_credits.csv",
      [:id, :packet_id, :call_id],
      [
        [:id, &parse_int/1],
        [:packet_id, &parse_int/1],
        [:call_id, &parse_int/1]
      ],
      %RebelCredit{}
    )
  end

  def seed_requirements do
    seed_db(
      "./priv/repo/seed/performance_requirements.csv",
      [:id, :from_date, :to_date, :calls, :hours, :partner_id, :rebel_id],
      [
        [:id, &parse_int/1],
        [:from_date, &parse_date/1],
        [:to_date, &parse_date/1],
        [:calls, &parse_int/1],
        [:hours, &parse_int/1],
        [:partner_id, &parse_int/1],
        [:rebel_id, &parse_int/1]
      ],
      %PerformanceRequirement{}
    )
  end

  def seed_rebel_work_quotas do
    seed_db(
      "./priv/repo/seed/rebel_work_quotas.csv",
      [:id, :rebel_id, :from_date, :to_date, :hours],
      [
        [:id, &parse_int/1],
        [:rebel_id, &parse_int/1],
        [:from_date, &parse_date/1],
        [:to_date, &parse_date/1],
        [:hours, &parse_float/1]
      ],
      %RebelWorkQuota{}
    )
  end

  def seed_leads do
    seed_db(
      "./priv/repo/seed/leads.csv",
      [:id, :company_name, :contact_name, :notes, :project_id, :rebel_id],
      [
        [:id, &parse_int/1],
        [:project_id, &parse_int/1],
        [:rebel_id, &parse_int/1]
      ],
      %Lead{}
    )
  end

  defp parse_int(num), do: String.to_integer(num)

  defp parse_float(num), do: String.to_float(num)

  defp parse_date(dt), do: Date.from_iso8601!(dt)

  defp parse_datetime(dt), do: NaiveDateTime.from_iso8601!(dt)

  defp parse_map(json) do
    result = json
    |> Jason.decode!
    |> Map.new(fn {k, v} -> {String.to_atom(k), v} end)

    IO.inspect result

    result
  end
end

#Seed.clear_db
## Seed.seed_rebels
#Seed.seed_sessions
## Seed.seed_partners
## Seed.seed_projects
## Seed.seed_leads
#Seed.seed_calls
#Seed.seed_documentations
#Seed.seed_project_rebels
## Seed.seed_packets
## Seed.seed_users
#Seed.seed_rebel_credits
#Seed.seed_requirements
#Seed.seed_rebel_work_quotas
