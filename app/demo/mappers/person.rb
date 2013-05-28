class Demo
  module Mappers

    include Models

    Demo::DB.build(Person, :default) do
      relation_name :people

      map :id,   Integer, :key => true
      map :name, String
    end
  end
end
