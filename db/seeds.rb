# Create the owner user (or find existing)
user = User.find_or_create_by!(email_address: "nathanjordaan@gmail.com") do |u|
  u.password = SecureRandom.hex(16)
end

# Create the CV
cv = Cv.find_or_create_by!(user: user) do |c|
  c.name = "Nathan Jordaan"
  c.email = "nathanjordaan@gmail.com"
  c.summary = "Full-stack developer with 9 years across logistics, mining and fintech. Designs, develops and deploys mobile, web, and data systems end-to-end."
  c.github_url = "https://github.com/duxpraetor/nathanjordaan"
  c.website_url = "https://nathanjordaan.com"
end

# Create tags
tag_names = [ "SQL", "Ruby on Rails", "C#", ".NET", "Angular", "React", "React Native", "Docker", "Git", "Scrum", "Razor", "OSIsoft", "Sage", "Azure IoT", "Azure Data Explorer", "Azure DevOps", "MSSQL", "Expo", "Java", "Drools", "Process Design" ]
tags = tag_names.index_with { |name| Tag.find_or_create_by!(name: name) }

# Tag the CV
cv.tags = [ tags["SQL"], tags["Ruby on Rails"], tags["C#"], tags[".NET"], tags["Angular"], tags["React"], tags["React Native"], tags["Docker"], tags["Git"], tags["Scrum"] ]

# Work experience section
work = cv.sections.find_or_create_by!(title: "Work experience", display_order: 1)

# ShipShape
shipshape = work.entries.find_or_create_by!(title: "ShipShape Software", display_order: 1) do |e|
  e.date_text = "2021 to present"
  e.meta = "SaaS · ERP · Logistics · Hybrid · Johannesburg"
  e.blurb = "Full development lifecycle — architecture, design, coding, deployment, support, and team management. Delegate work to a small team, manage PRs, and handle production releases directly."
end

b1 = shipshape.bullets.find_or_create_by!(description: "Redesign and rewrite of a Transport Management (TMS) Android app", display_order: 1)
b1.tags = [ tags["React Native"], tags["C#"], tags["MSSQL"], tags["Expo"] ]

b2 = shipshape.bullets.find_or_create_by!(description: "Redesign and rewrite of existing freight forwarder ERP", display_order: 2)
b2.tags = [ tags["Angular"], tags["C#"], tags["MSSQL"], tags["Azure DevOps"], tags["Docker"] ]

# AM2
am2 = work.entries.find_or_create_by!(title: "AM² Systems", display_order: 2) do |e|
  e.date_text = "2017 to 2021"
  e.meta = "Startup · Mining · Petrochem · Hybrid · Johannesburg"
  e.blurb = "Introduced Scrum and ran company-wide knowledge sharing sessions. Built systems across multiple industries. Designed and implemented multiple applications and modules."
end

b3 = am2.bullets.find_or_create_by!(description: "Industrial data portal — built a C# wrapper around the OSIsoft SDK for web access without direct DB connection", display_order: 1)
b3.tags = [ tags["Razor"], tags["C#"], tags["OSIsoft"] ]

b4 = am2.bullets.find_or_create_by!(description: "Fruit export web app with Sage integrations", display_order: 2)
b4.tags = [ tags["Razor"], tags["C#"], tags["Sage"] ]

b5 = am2.bullets.find_or_create_by!(description: "Service ingesting Azure IoT streams into Azure Data Explorer", display_order: 3)
b5.tags = [ tags["C#"], tags["Azure IoT"], tags["Azure Data Explorer"] ]

# Entelect
entelect = work.entries.find_or_create_by!(title: "Entelect", display_order: 3) do |e|
  e.date_text = "2016"
  e.meta = "Contracting · Fintech · Johannesburg"
  e.blurb = "Delivered features within a structured 2-week scrum team."
end

b6 = entelect.bullets.find_or_create_by!(description: "Migrated investment business rules to Drools, working closely with a business analyst", display_order: 1)
b6.tags = [ tags["C#"], tags["Java"], tags["Drools"] ]

b7 = entelect.bullets.find_or_create_by!(description: "Redesigned the investment approval workflow with the product owner", display_order: 2)
b7.tags = [ tags["Process Design"] ]

# Personal Projects section
projects = cv.sections.find_or_create_by!(title: "Personal Projects", display_order: 2)
mysrc = projects.entries.find_or_create_by!(title: "mysrc", display_order: 1) do |e|
  e.date_text = "2025"
  e.blurb = "Rails app for a recycling company — quotes, shipments, pricing, email lists"
end
mysrc.tags = [ tags["Ruby on Rails"], tags["Docker"] ]

# Education section
education = cv.sections.find_or_create_by!(title: "Education", display_order: 3)
wits = education.entries.find_or_create_by!(title: "University of the Witwatersrand", display_order: 1) do |e|
  e.subtitle = "BSc (Eng) Electrical and Information Engineering"
  e.date_text = "2012–2015"
end

puts "Seeded CV for #{cv.name}"
