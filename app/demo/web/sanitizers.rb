class Demo
  module Web

    module Sanitizers

      NEW_PERSON = Ducktrap.build do
        primitive(Hash)
        hash_transform do
          dump_key(:name) do
            fetch_key('name')
            primitive(String)
          end
        end
        anima_load(Models::Person)
      end

    end
  end
end
