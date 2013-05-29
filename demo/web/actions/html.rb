class Demo
  module Web
    module Actions

      module Html

        LIST_PEOPLE = Substation::Chain.new [
          Actions::LIST_PEOPLE,
          Wrapper.new(Presenters::Person::Collection),
          Renderer.new(Web::Views::Person::LIST)
        ]

        NEW_PERSON = Substation::Chain.new [
          Actions::NEW_PERSON,
          Renderer.new(Web::Views::Person::NEW)
        ]

        LOAD_PERSON = Substation::Chain.new [
          Actions::LOAD_PERSON,
          Wrapper.new(Presenters::Person),
          Renderer.new(Web::Views::Person::SHOW)
        ]

      end
    end
  end
end
