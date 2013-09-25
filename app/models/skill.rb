class Skill < ActiveRecord::Base
 require 'rubygems'
 require 'roo' 

  attr_accessible :name
  has_and_belongs_to_many :users

  # after_save :reindex_users!
  # # Reindex corresponding user only , instead of whole class.
  # def reindex_users!
  #     Sunspot.index! self.users
  # end  



  def self.import(path = Rails.root.join('lib','data/skills.xlsx'))
   unless path.blank?
    Skill.delete_all
    file =  File.open(path,"r")
    spreadsheet = open_spreadsheet(file)
    header = spreadsheet.row(1)
      (2..spreadsheet.last_row).each do |i|
        row = Hash[[header.map!(&:downcase), spreadsheet.row(i)].transpose]
        skill = Skill.new
        skill.attributes = row.to_hash.slice(*accessible_attributes)
        skill.save!
      end
      file.close
   end
 end	

 def self.open_spreadsheet(file)
  
  case File.extname(File.basename(file.path))
  #case File.extname(file.original_filename)
  when ".csv" then Csv.new(file.path, nil, :ignore)
  when ".xls" then Excel.new(file.path, nil, :ignore)
  when ".xlsx" then Excelx.new(file.path, nil, :ignore)
  else raise "Unknown file type: #{file.original_filename}"
  end
end

end
