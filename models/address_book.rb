require_relative 'entry'
require 'csv'

class AddressBook
  attr_reader :entries

  def initialize
    @entries = []
  end

  def add_entry(name, phone_number, email)

    index = 0
    entries.each do |entry|
      if name < entry.name
        break
      end
      index+= 1
    end
    entries.insert(index, Entry.new(name, phone_number, email))
  end

  def remove_entry(name, phone_number, email)
    entries.each_with_index do |entry, index|
      if entry.name == name && entry.phone_number == phone_number && entry.email == email
        entries.delete_at(index)
      end
    end
  end

  def import_from_csv(file_name)
    csv_text = File.read(file_name)
    #parse is an object type of CSV::Table
    csv = CSV.parse(csv_text, headers:true, skip_blanks: true)
    csv.each do |row| # we create hash for each row.
      row_hash = row.to_hash
      #add entry will convert each row_hash to an Entry
      add_entry(row_hash["name"], row_hash["phone_number"], row_hash["email"])
    end
  end

end
