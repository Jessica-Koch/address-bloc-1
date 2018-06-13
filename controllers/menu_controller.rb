require_relative '../models/address_book'
require 'paint'

class MenuController
  attr_reader :address_book

  def initialize
    @address_book = AddressBook.first
  end

  def main_menu
    puts Paint["#{@address_book.name} Address Book – Selected\n#{@address_book.entries.count} entries", :white, :bright]
    puts Paint['0 - Switch AddressBook', '#48D1CC']
    puts Paint["1 - View all entries", "#48D1CC"]
    puts Paint["2 - Create an entry", "#48D1CC"]
    puts Paint["3 - Search for an entry", "#48D1CC"]
    puts Paint["4 - Import entries from a CSV", "#48D1CC"]
    puts Paint["5 - Exit", "#48D1CC"]
    print Paint["Enter your selection: ", :white, :bright]

    selection = gets.to_i

    case selection
    when 0
      system 'clear'
      select_address_book_menu
      main_menu
    when 1
      system 'clear'
      view_all_entries
      main_menu
    when 2
      system 'clear'
      create_entry
      main_menu
    when 3
      system 'clear'
      search_entries
      main_menu
    when 4
      system 'clear'
      read_csv
      main_menu
    when 5
      puts "Good-bye!"
      exit(0)
    else
      system 'clear'
      puts Paint["Sorry, that is not a valid input", "#FF4500"]
      main_menu
    end
  end

  def select_address_book_menu
    puts "Select an Address Book:"
    AddressBook.all.each_with_index do |address_book, index|
      puts "#{index} - #{address_book.name}"
    end

    index = gets.chomp.to_i

    @address_book = AddressBook.find(index + 1)
    system 'clear'
    return if @address_book
    puts "Please select a valid index"
    select_address_book_menu
  end
  def view_all_entries
    @address_book.entries.each do |entry|
      system 'clear'
      puts entry.to_s
      entry_submenu(entry)
    end

    system 'clear'
    puts "End of entries"
  end

  def create_entry
    system 'clear'
    puts 'New AddressBloc Entry'
    print 'Name: '
    name = gets.chomp
    print 'Phone number: '
    phone = gets.chomp
    print 'Email: '
    email = gets.chomp

    address_book.add_entry(name, phone, email)

    system 'clear'
    puts 'New entry created'
  end

  def search_entries
    print 'Search by name: '
    name = gets.chomp

    match = @address_book.find_entry(name)
    system 'clear'
    if match
      puts match.to_s
      search_submenu(match)
    else
      puts "No match found for #{name}"
    end
  end

  def read_csv
    print "Enter CSV file to import: "
    file_name = gets.chomp

    if file_name.empty?
      system 'clear'
      puts "No CSV file read"
      main_menu
    end

    begin
      entry_count = address_book.import_from_csv(file_name).count
      system 'clear'
      puts "#{entry_count} new entries added from #{file_name}"
    rescue
      puts "#{file_name} is not a valid CSV file, please enter the name of a valid CSV file"
      read_csv
    end
  end

  def entry_submenu(entry)
    puts Paint["n - next entry", "#48D1CC"]
    puts Paint["d - delete entry", "#48D1CC"]
    puts Paint["e - edit this entry", "#48D1CC"]
    puts Paint["m - return to main menu", "#48D1CC"]
    puts Paint["q - exit", "#48D1CC"]

    selection = gets.chomp

    case selection
      when "n"
      when "d"
        delete_entry(entry)
      when "e"
        edit_entry(entry)
        entry_submenu(entry)
      when "m"
        system 'clear'
        main_menu
      when "q"
        puts "Good-bye!"
        exit(0)
      else
        system 'clear'
        puts Paint["#{selection} is not a valid input", "#FF4500"]
        entry_submenu(entry)
    end
  end

  def delete_entry(entry)
    address_book.entries.delete(entry)
    puts "#{entry.name} has been deleted"
  end

  def edit_entry(entry)
    print "Updated name: "
    name = gets.chomp
    print "Updated phone number: "
    phone_number = gets.chomp
    print "Updated email: "
    email = gets.chomp
    entry.name = name if !name.empty?
    entry.phone_number = phone_number if !phone_number.empty?
    entry.email = email if !email.empty?
    system 'clear'
    puts "Updated entry:"
    puts entry
  end

  def search_submenu(entry)
    puts Paint["\nd - delete entry", "#48D1CC"]
    puts Paint["e - edit this entry", "#48D1CC"]
    puts Paint["m - return to main menu", "#48D1CC"]
    puts Paint["q - exit", "#48D1CC"]
    selection = gets.chomp

    case selection
      when "d"
        system 'clear'
        delete_entry(entry)
        main_menu
      when "e"
        edit_entry(entry)
        system 'clear'
        main_menu
      when "m"
        system 'clear'
        main_menu
      when "q"
        puts "Good-bye!"
        exit(0)
      else
        system 'clear'
        puts Paint["#{selection} is not a valid input",  "#FF4500"]
        puts entry.to_s
        search_submenu(entry)
    end
  end
end

