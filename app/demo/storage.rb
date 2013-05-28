class Demo

  class Storage
    include Equalizer.new(:db)
    include Models

    INSERT_PERSON_DDL = <<-SQL
      INSERT INTO "people" ("id", "name") VALUES (?, ?)
    SQL

    attr_reader :db

    def initialize(db)
      @db  = db
      @uri = db.repository(:default).adapter.uri # hack
    end

    def list_people
      db[Person].all
    end

    def load_person(id)
      db[Person].one(:id => id)
    end

    def insert_person(person)
      connection = DataObjects::Connection.new(@uri)

      command = connection.create_command(INSERT_PERSON_DDL)
      command.execute_non_query(person.id, person.name)

      connection.close
    end
  end
end
