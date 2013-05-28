class Demo

  class Storage
    include Equalizer.new(:db)
    include Models

    INSERT_PERSON_DDL = <<-SQL
      INSERT INTO "people" ("name") VALUES (?)
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
      insert(INSERT_PERSON_DDL, person.name)
    end

    private

    def insert(ddl, *args)
      connection = DataObjects::Connection.new(@uri)
      command = connection.create_command(ddl)
      command.execute_non_query(*args)
      connection.close
    end
  end
end
