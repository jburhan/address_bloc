require_relative 'controllers/menu_controller'

menu = MenuController.new

system "clear" # used to clear the command line
puts "Welcome to AddressBloc!"

menu.main_menu #displays the main menu
