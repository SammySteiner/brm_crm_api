# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

arm = Role.create(title: 'ARM', description: 'Agency Relation Manager')

sammy = Staff.create(name: 'Sammy Steiner', email: 'sasteiner@doitt.nyc.gov', phone: '7184038786', role_id: 1)

agency = Agency.create(name: 'Department of Information Technology', acronym: 'DoITT', category: 1, mayoral: true, citynet: true, commissioner_id: 1, cio_id: 1, arm_id: 1)

sammy_doitt = StaffAgency.create(staff_id: 1, agency_id: 1)

engagement_type = EngagementType.create(medium: 'CIO Check In')

engagement = Engagement.create(engagement_type_id: 1, cio: true, date: DateTime.now(), notes: 'an awesome CIO meeting with nothing to report')

attendance = StaffEngagement.create(staff_id: 1, engagement_id: 1)

service = Service.create(title: 'arm assistance', description: 'Have your arm help you with whatever escalations you need!', sla: 5, sdl_id: 1)

event = Event.create(title: 'test event', description: 'this is going to be a great test event.', location: '123 Fake St.', time: DateTime.now())

execom = ExecutiveCommunication.create(subject: 'something important', content: 'this is the body of the really important email.', time: DateTime.now())

issue = Issue.create(description: 'this is a really important issue', notes: 'after connecting with the agency, we need to help!', escalation: true, priority: 1, actionable: false, ksr: 'ksr12345', key_project: true, agency_id: 1, service_id: 1, engagement_id: 1, created_by_id: 1, start_time: DateTime.now(), last_modified_on: DateTime.now(), last_modified_by_id: 1)

# t.text :description
# t.text :notes
# t.boolean :escalation
# t.integer :priority
# t.boolean :actionable
# t.string :ksr
# t.boolean :key_project
# t.references :agency, foreign_key: true
# t.references :service, foreign_key: true
# t.references :engagement, foreign_key: true
# t.integer :created_by
# t.datetime :start_time
# t.datetime :last_modified_on
# t.integer :last_modified_by
# t.datetime :resolved_on
# t.text :resolution_notes
