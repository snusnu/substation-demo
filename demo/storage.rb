class Demo

  class Storage
    include Equalizer.new(:db)
    include Models

    INSERT_PERSON_STMT = <<-SQL
      INSERT INTO "people" ("name") VALUES (?) RETURNING "id"
    SQL

    attr_reader :db

    def initialize(db)
      @db  = db
      @uri = Demo::DEFAULT_DB_URI
    end

    def list_people
      db[Person].all
    end

    def load_person(id)
      db[Person].one(:id => id)
    end

    def insert_person(person)
      person.update(:id => execute(INSERT_PERSON_STMT, person.name))
    end

    private

    def execute(statement, *bind_values)
      with_connection do |connection|
        command = connection.create_command(statement)
        result = command.execute_non_query(*bind_values)
        result.insert_id
      end
    end

    def with_connection
      yield connection = DataObjects::Connection.new(@uri)
    ensure
      connection.close
    end
  end
end
