class Demo
  module Web
    module Presenters

      class Person < Presenter

        def name
          "Presenting: #{super}"
        end

        class Collection < Presenter::Collection
          member(Person)
          alias_method :people, :each
        end
      end
    end
  end
end
