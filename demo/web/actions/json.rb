class Demo
  module Web
    module Actions

      module Json

        LOAD_PERSON = Substation::Chain.new [
          Actions::LOAD_PERSON,
          Serializer::JSON::Model.new
        ]

        CREATE_PERSON = Substation::Chain.new [
          Actions::CREATE_PERSON,
        ]

      end
    end
  end
end
