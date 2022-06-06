alias Dashboard.Repo
alias Dashboard.{Entities, Sales, Finance, Accounts, Metrics}
alias Dashboard.Entities.{Partner, Rebel, Project, Lead}
alias Dashboard.Sales.{Call, Session, Documentation, ProjectRebel, PerformanceRequirement}
alias Dashboard.Finance.{Packet, RebelCredit}
alias Dashboard.Metrics.RebelWorkQuota
alias Dashboard.Accounts.User

# === Sales Admin
code = "code1"
Accounts.create_activation_code(%{code: code})

Accounts.register_user(%{
  email: "admin@gmail.com",
  role: "saleup",
  password: "admin",
  password_confirmation: "admin",
  code: code
})

# == Example Partner
partner = %Partner{
  name: "Telekom"
}
|> Repo.insert!

project = %Project{
  name: "Testphase",
  partner_id: partner.id
}
|> Repo.insert!

# === Rebel Michael
michael = %Rebel{
  first_name: "Michael",
  last_name: "Bento"
}
|> Repo.insert!

%ProjectRebel{
  rebel_id: michael.id,
  project_id: project.id
}
|> Repo.insert!

code = "code2"
Accounts.create_activation_code(%{code: code})

Accounts.register_user(%{
  email: "michael@gmail.com",
  role: "rebel",
  password: "michael1839",
  password_confirmation: "michael1839",
  code: code,
  rebel_id: michael.id
})

# === Rebel Jan
jan = %Rebel{
  first_name: "Jan",
  last_name: "Diemer"
}
|> Repo.insert!

%ProjectRebel{
  rebel_id: jan.id,
  project_id: project.id
}
|> Repo.insert!

code = "code3"
Accounts.create_activation_code(%{code: code})

Accounts.register_user(%{
  email: "jan@gmail.com",
  role: "rebel",
  password: "jan1928",
  password_confirmation: "jan1928",
  code: code,
  rebel_id: jan.id
})

# === Rebel Tim
tim = %Rebel{
  first_name: "Tim",
  last_name: "Muer"
}
|> Repo.insert!

%ProjectRebel{
  rebel_id: tim.id,
  project_id: project.id
}
|> Repo.insert!

code = "code4"
Accounts.create_activation_code(%{code: code})

Accounts.register_user(%{
  email: "tim@gmail.com",
  role: "rebel",
  password: "tim6549",
  password_confirmation: "tim6549",
  code: code,
  rebel_id: tim.id
})

