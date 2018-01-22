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

# create_table :events do |t|
#   t.string :title
#   t.text :description
#   t.string :location
#   t.datetime :time
#
#   create_table :executive_communications do |t|
#     t.string :subject
#     t.text :content
#     t.datetime :time

# t.references, :engagement_type
# t.boolean, :cio
# t.datetime, :date
# t.text :notes

# t.string :name
# t.string :acronym
# t.integer :category
# t.boolean :mayoral
# t.boolean :citynet
# t.references :commissioner, references: :staffs
# t.references :cio, references: :staffs
# t.references :arm, references: :staffs
