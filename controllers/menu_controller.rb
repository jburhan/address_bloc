require_relative '../models/address_book'

class MenuController
  attr_reader :address_book

  def initialize
    @address_book = AddressBook.new
  end

  def main_menu
    puts "Main Menu - #{address_book.entries.count} entries"
    puts "1 - View all entries"
    puts "2 - Create an entry"
    puts "3 - Search for an entry"
    puts "4 - Import entries from a CSV"
    puts "5 - View Entry Number n"
    puts "6 - Exit"
    print "Enter your selection: "

    selection = gets.to_i
    # gets is used to read line from standard input

    case selection #case statement operator determins the proper response
      when 1
        system "clear"
        view_all_entries
        main_menu
      when 2
        system "clear"
        create_entry
        main_menu
      when 3
        system "clear"
        search_entries
        main_menu
      when 4
        system "clear"
        read_csv
        main_menu
      when 5
        system "clear"
        specific_entry
        main_menu
      when 6
        puts "Good-Bye!"
        exit (0) #terminate the program, 0 signals the program is exiting
      else #catch invalid user input
        system "clear"
        puts "Sorry, that is not a valid input"
        main_menu
    end
  end

#define the rest of the menu of a entry
    def view_all_entries
      address_book.entries.each do |entry|
        system "clear"
        puts entry.to_s

        entry_submenu(entry) #display submenu for each entry
      end

      system "clear"
      puts "End of entries"
    end

    def create_entry
      system "clear"
      puts "New AddressBloc Entry"

      # print works like puts but it doesnt add a newline
      print "Name: "
      name = gets.chomp
      print "Phone Number: "
      phone = gets.chomp
      print "Email: "
      email = gets.chomp

      address_book.add_entry(name, phone, email)

      system "clear"
      puts "New entry created"
    end

    def search_entries
      print "Search by name: "
      name = gets.chomp

      match = address_book.binary_search(name)
      system "clear"

      if match
        puts match.to_s
        search_submenu(match)
      else
        puts "No match found for #{name}"
      end

    end

    def delete_entry(entry)
      address_book.entries.delete(entry)
      puts "#{entry.name} has been deleted"
    end

    def edit_entry(entry)
      # gather user inputs
      print "Updated name: "
      name = gets.chomp
      print "Updated phone number: "
      phone_number = gets.chomp
      print "Updated email: "
      email = gets.chomp
      # this !attribute.empty? is used to set attributes on entry
      # only if a valid attribute was read from user input
      entry.name = name if !name.empty?
      entry.phone_number = phone_number if !phone_number.empty?
      entry.email = email if !email.empty?
      system "clear"

      puts "Updated entry:"
      puts entry
    end

    def read_csv
      # we prompt the user to enter a name of a CSV file to import
      # filename from STDIN and call chomp method to remove newlines
      print "Enter CSV file to import: "
      file_name = gets.chomp

      # this is to check if the file name is empty
      if file_name.empty?
        system "clear"
        puts "No CSV file read"
        main_menu
      end

      # we import the file wih import_from_csv on address_book
      # we then clear the screen and print the number of entries
      # then we have begin/rescue block to protect the program
      begin
        entry_count = address_book.import_from_csv(file_name).count
        system "clear"
        puts "#{entry_count} new entries added from #{file_name}"
      rescue
        puts "#{file_name} is not a valid CSV file, please enter the name of a valid CSV file"
        read_csv
      end

    end

    def specific_entry

      print "Enter number to view: "
      selection = gets.chomp.to_i

      puts address_book.entries[selection - 1]

    end

    def search_submenu(entry)

      puts "\nd - delete entry"
      puts "e - edit this entry"
      puts "m - return to main menu"

      selection = gets.chomp

      case selection

      when "d"
        system "clear"
        delete_entry(entry)
        main_menu
      when "e"
        edit_entry(entry)
        system "clear"
        main_menu
      when "m"
        system "clear"
        main_menu
      else
        system "clear"
        puts "#{selection} is not a valid input"
        puts entry.to_s
        search_submenu(entry)

      end

    end

    def entry_submenu(entry)

      puts "n - next entry"
      puts "d - delete entry"
      puts "e - edit this entry"
      puts "m - return to main menu"

      selection = gets.chomp #chomp removes trailing whitespace from the string
                            # this is important because we could have m\n instead of just m

      case selection
        when "n"
        when "d"
          delete_entry(entry)
        when "e"
          edit_entry(entry)
          entry_submenu(entry)
        when "m"
          system "clear"
          main_menu
        else
          system "clear"
          puts "#{selection} is not a valid input"
          entry_submenu(entry)
      end

    end

end
