require_relative '../models/address_book'
require_relative '../models/entry'
require 'bloc_record'

BlocRecord.connect_to('db/address_bloc.sqlite')

book = AddressBook.create(name: 'My Address Book')

puts 'Address Book created'
puts 'Entry created'
puts Entry.create(address_book_id: book.id, name: 'Foo One', phone_number: '999-999-9999', email: 'foo_one@gmail.com')
puts Entry.create(address_book_id: book.id, name: 'Foo Two', phone_number: '111-111-1111', email: 'foo_two@gmail.com' )
puts Entry.create(address_book_id: book.id, name: 'Foo Three', phone_number: '222-222-2222', email: 'foo_three@gmail.com' )
puts Entry.create(address_book_id: book.id, name: 'Jessica Koch', phone_number: '412-805-0853', email: 'jessicakoch136@icloud.com' )
puts Entry.create(address_book_id: book.id, name: 'Walker Linna', phone_number: '206-765-8693', email: 'walkerlinna@walker.com' )
puts Entry.create(address_book_id: book.id, name: 'Grayson Williams', phone_number: '123-111-111', email: 'grayson@gmail.com' )
