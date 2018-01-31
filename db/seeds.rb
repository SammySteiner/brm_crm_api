# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'csv'

def roles_import
  csv_text = File.read(Rails.root.join('lib', 'seeds', 'roles.csv'))
  csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
  csv.each do |row|
    t = Role.new
    t.title = row[0].strip
    t.description = row['description'].strip
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
    t.title = row["title"].strip
    t.description = row["description"].strip
    t.sla = row['sla'].strip
    sdl = row['sdl'].strip
    first = sdl.split(' ')[0].strip
    last = sdl.split(' ')[1].strip
    t.sdl_id = Staff.find_by(first_name:first, last_name:last).id
    t.division_id = row["division"]
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

roles_import
agencies_import
staff_import
arms_agencies_import
cios_agencies_import
commissioners_agencies_import
divisions_import
services_import







# arm = Role.create(title: 'ARM', description: 'Agency Relation Manager')
#
# agency = Agency.create(name: 'Department of Information Technology', acronym: 'DoITT', category: 1, mayoral: true, citynet: true)
#
# sammy = Staff.create(first_name: 'Sammy', last_name: 'Steiner', email: 'sasteiner@doitt.nyc.gov', office_phone: '7184038786', cell_phone: '6465744359', role_id: 1, agency_id: 1)
#
# engagement_type = EngagementType.create(medium: 'CIO Check In')
#
# engagement = Engagement.create(engagement_type_id: 1, cio: true, date: DateTime.now(), notes: 'an awesome CIO meeting with nothing to report')
#
# attendance = StaffEngagement.create(staff_id: 1, engagement_id: 1)
#
# service = Service.create(title: 'arm assistance', description: 'Have your arm help you with whatever escalations you need!', sla: 5, sdl_id: 1)
#
# event = Event.create(title: 'test event', description: 'this is going to be a great test event.', location: '123 Fake St.', time: DateTime.now())
#
# execom = ExecutiveCommunication.create(subject: 'something important', content: 'this is the body of the really important email.', time: DateTime.now())
#
# issue = Issue.create(description: 'this is a really important issue', notes: 'after connecting with the agency, we need to help!', escalation: true, priority: 1, actionable: false, ksr: 'ksr12345', key_project: true, agency_id: 1, service_id: 1, engagement_id: 1, created_by_id: 1, start_time: DateTime.now(), last_modified_on: DateTime.now(), last_modified_by_id: 1)
