# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'csv'
require 'faker'

def roles_import
  csv_text = File.read(Rails.root.join('lib', 'seeds', 'roles.csv'))
  csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
  csv.each do |row|
    t = Role.new
    t.title = row[0].strip
    t.description = row['description'].strip
    puts t.title
    t.save
  end
end

def agencies_import
  csv_text = File.read(Rails.root.join('lib', 'seeds', 'agencies.csv'))
  csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
  csv.each do |row|
    t = Agency.new
    t.name = row["name"].strip
    t.acronym = row['acronym']
    t.category = row['category'].strip
    t.mayoral = row['mayoral'].strip
    t.citynet = row['citynet']
    t.address = row['address']
    puts t.name
    t.save
  end
end

def staff_import
  csv_text = File.read(Rails.root.join('lib', 'seeds', 'staff.csv'))
  csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
  csv.each do |row|
    t = Staff.new
    t.first_name = row["﻿first_name"].strip
    t.last_name = row["last_name"].strip
    t.email = row['email']
    t.office_phone = row['office_phone']
    t.cell_phone = row['cell_phone']
    t.role_id = row['role_id'].strip
    t.agency_id = row['agency_id'].strip
    puts t.last_name
    t.save
  end
end

def divisions_import
  csv_text = File.read(Rails.root.join('lib', 'seeds', 'divisions.csv'))
  csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
  csv.each do |row|
    t = Division.new
    t.name = row["Name"].strip
    dc = row['Deputy Commissioner'].strip
    first = dc.split(' ')[0].strip
    last = dc.split(' ')[1].strip
    t.deputy_commissioner_id = Staff.find_by(first_name:first, last_name:last).id
    puts t.name
    t.save
  end
end

def services_import
  csv_text = File.read(Rails.root.join('lib', 'seeds', 'services.csv'))
  csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
  csv.each do |row|
    t = Service.new
    t.title = row[0].strip
    t.description = row["description"].strip
    sdl_first = row['sdl_first_name'].strip
    sdl_last = row['sdl_last_name'].strip
    t.sdl_id = Staff.find_by(first_name:sdl_first, last_name:sdl_last).id
    service_owner_first = row['service_owner_first_name'].strip
    service_owner_last = row['service_owner_last_name'].strip
    t.service_owner_id = Staff.find_by(first_name:service_owner_first, last_name:service_owner_last).id
    division = Division.find_by(name: row["division"])
    t.division_id = division.id
    puts t.title
    t.save
  end
end

def arms_agencies_import
  csv_text = File.read(Rails.root.join('lib', 'seeds', 'arms_agencies.csv'))
  csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
  csv.each do |row|
    t = ArmAgency.new
    arm = row['arm'].strip
    first = arm.split(' ')[0].strip
    last = arm.split(' ')[1].strip
    t.arm_id = Staff.find_by(first_name:first, last_name:last).id
    agency = row['agency'].strip
    t.agency = Agency.find_by(acronym: agency)

    t.save
  end
end

def cios_agencies_import
  csv_text = File.read(Rails.root.join('lib', 'seeds', 'cios_agencies.csv'))
  csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
  csv.each do |row|
    t = CioAgency.new
    cio = row[0].strip
    first = cio.split(' ')[0].strip
    last = cio.split(' ')[1].strip
    if cio.split(' ').count === 3
      last = cio.split(' ')[1].strip + ' ' + cio.split(' ')[2].strip
    end
    t.cio_id = Staff.find_by(first_name:first, last_name:last).id
    agency = row['agency'].strip
    t.agency = Agency.find_by(acronym: agency)
    t.save
  end
end

def commissioners_agencies_import
  csv_text = File.read(Rails.root.join('lib', 'seeds', 'commissioners_agencies.csv'))
  csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
  csv.each do |row|
    t = CommissionerAgency.new
    commissioner = row[0].strip
    first = commissioner.split(' ')[0].strip
    last = commissioner.split(' ')[1].strip
    if commissioner.split(' ').count === 3
      last = commissioner.split(' ')[1].strip + ' ' + commissioner.split(' ')[2].strip
    end
    t.commissioner_id = Staff.find_by(first_name:first, last_name:last).id
    agency = row['agency'].strip
    t.agency = Agency.find_by(acronym: agency)
    t.save
  end
end

def connection_types_import
  csv_text = File.read(Rails.root.join('lib', 'seeds', 'connection_types.csv'))
  csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
  csv.each do |row|
    t = ConnectionType.new
    t.via = row["﻿via"].strip
    puts t.via
    t.save
  end
end

def engagement_types_import
  csv_text = File.read(Rails.root.join('lib', 'seeds', 'engagement_types.csv'))
  csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
  csv.each do |row|
    t = EngagementType.new
    t.via = row["﻿via"].strip
    puts t.via
    t.save
  end
end

roles_import
agencies_import
staff_import
arms_agencies_import
cios_agencies_import
commissioners_agencies_import
divisions_import
services_import
connection_types_import
# connections_import
engagement_types_import
# engagements_import


User.create(email: 'sasteiner@doitt.nyc.gov', password: '123')

100.times do
  arm_id = rand(1..6)
  agency = Staff.find(arm_id).assignments.sample
  c = Connection.create(date: Faker::Time.backward(90, :day), report: Faker::Lorem.paragraph(2), notes: Faker::HitchhikersGuideToTheGalaxy.quote, connection_type: ConnectionType.find(rand(1..4)), arm_id: arm_id, agency: agency)
  StaffConnection.create(staff_id: c.arm_id, connection: c)
  if agency.cio
    StaffConnection.create(staff_id: agency.cio.id, connection: c)
  end
  rand(1..3).times do
    service = Service.find(rand(1..50))
    e = Engagement.new(
      title: Faker::Book.title,
      report: Faker::Hipster.sentence,
      notes: Faker::Hipster.paragraph,
      ksr: Faker::Number.number,
      inc: Faker::Number.number,
      priority: rand(1..3),
      service: service,
      connection: c,
      engagement_type: EngagementType.find(rand(1..4)),
      created_by_id: arm_id,
      last_modified_by_id: arm_id,
      start_time: Faker::Time.backward(10, :day)
    )
    StaffEngagement.create(staff_id: arm_id, engagement: e)
    StaffEngagement.create(staff_id: service.sdl.id, engagement: e)
    if agency.cio
      StaffEngagement.create(staff_id: agency.cio.id, engagement: e)
    end
  end
  puts c.notes
end

# created_by_id: Staff.find_by(email: User.find(@current_user).email)
