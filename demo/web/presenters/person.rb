class Demo
  module Web
    module Presenters

      class Person < Presenter

        def name
          "Mr. #{super}"
        end
      end
    end
  end
end
