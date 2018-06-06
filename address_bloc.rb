require_relative 'controllers/menu_controller'
require 'bloc_record'
require 'paint'

BlocRecord.connect_to("db/address_bloc.sqlite")

menu = MenuController.new
system "clear"
puts Paint["Welcome to AddressBloc!", '#9400D3', :bright, :clean]
puts ''
menu.main_menu
