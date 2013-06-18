class Demo
  module Web
    module Actions

      module Json

        LOAD_PERSON = Web::ENV.chain(Actions::LOAD_PERSON) do
          use Serializer::JSON::MODEL
        end

        CREATE_PERSON = Web::ENV.chain(Actions::CREATE_PERSON) do
        end

      end
    end
  end
end
