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
    end

    def read_csv
    end

    def specific_entry
      print "Enter number to view: "
      selection = gets.chomp.to_i

      puts address_book.entries[selection - 1]

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
        when "e"
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
