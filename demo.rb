require 'pp'
require 'set'
require 'pathname'

require 'adamantium'
require 'equalizer'
require 'concord'
require 'abstract_type'
require 'aequitas'
require 'ducktrap'
require 'anima'
require 'dm-mapper'
require 'axiom-do-adapter'
require 'do_postgres'
require 'data_mapper/support/axiom/adapter/postgres'
require 'substation'

class Demo
  include Concord.new(:dispatcher)
  include Adamantium::Flat

  database = ENV.fetch('DB') {
    puts "Start the app like this (only postgres supported): DB=my_db rackup config.ru"
    exit(1)
  }

  DB = DataMapper::Environment.coerce(:default => "postgres://localhost/#{database}")

  def call(name, input = nil)
    @dispatcher.call(name, input)
  end

  require 'demo/actions'
  require 'demo/validators'
  require 'demo/models'
  require 'demo/mappers'
  require 'demo/storage'
  require 'demo/environment'

  ENV = Environment.new(Storage.new(Demo::DB))

  DB.finalize

  module Models

    # seed some data
    # ENV.storage.insert_person Person.new(:id => 1, :name => 'John')
    # ENV.storage.insert_person Person.new(:id => 2, :name => 'Jane')

  end
end
