# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
ZipCode.delete_all
CSV.foreach("#{Rails.root}/lib/data/zip-codes-database-STANDARD.csv", :headers => :first_row) do |row|
  ZipCode.create!(row.to_hash)
end
