class Demo
  module Web

    module Serializers
      module JSON

        class Person < Presenter
          def to_json(*args)
            MultiJson.dump({ 'full_name' => name }, :pretty => true)
          end
        end
      end
    end
  end
end
