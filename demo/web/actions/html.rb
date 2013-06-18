class Demo
  module Web
    module Actions

      module Html

        LIST_PEOPLE = Web::ENV.chain(Actions::LIST_PEOPLE) do
          wrap   Presenters::Person::Collection
          render Web::Views::Person::LIST
        end

        NEW_PERSON = Web::ENV.chain(Actions::NEW_PERSON) do
          render Web::Views::Person::NEW
        end

        LOAD_PERSON = Web::ENV.chain(Actions::LOAD_PERSON) do
          wrap   Presenters::Person
          render Web::Views::Person::SHOW
        end

      end
    end
  end
end
