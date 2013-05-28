class Demo
  module Web

    module Actions

      LIST_PEOPLE = Substation::Chain.new [
        Pivot.new(Demo::Actions::ListPeople),
      ]

      NEW_PERSON = Substation::Chain.new [
        Pivot.new(Demo::Actions::NewPerson),
      ]

      LOAD_PERSON = Substation::Chain.new [
        Pivot.new(Demo::Actions::LoadPerson),
      ]

      CREATE_PERSON = Substation::Chain.new [
        Sanitizer.new(Sanitizers::NEW_PERSON),
        Validator.new(Demo::Validators::NEW_PERSON),
        Pivot.new(Demo::Actions::CreatePerson),
      ]

    end
  end
end
