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

  DEFAULT_DB_NAME = ENV.fetch('DB') {
    puts "Start like this (do_postgres only): DB=my_db rackup config.ru"
    exit(1)
  }.freeze

  DEFAULT_DB_URI = "postgres://localhost/#{DEFAULT_DB_NAME}".freeze

  DB = DataMapper::Environment.coerce(:default => DEFAULT_DB_URI)

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
end
