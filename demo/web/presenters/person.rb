class Demo
  module Web
    module Presenters

      class Person < Presenter

        def name
          "Presenting: #{super}"
        end
      end

      class People < Presenter::Collection
        member(Presenters::Person)
        alias_method :people, :each
      end
    end
  end
end
