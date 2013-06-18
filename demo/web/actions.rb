class Demo
  module Web

    module Actions

      LIST_PEOPLE = Web::ENV.chain do
        call Demo::Actions::ListPeople
      end

      NEW_PERSON = Web::ENV.chain do
        call Demo::Actions::NewPerson
      end

      LOAD_PERSON = Web::ENV.chain do
        call Demo::Actions::LoadPerson
      end

      CREATE_PERSON = Web::ENV.chain do
        evaluate Sanitizers::NEW_PERSON
        evaluate Demo::Validators::NEW_PERSON

        call Demo::Actions::CreatePerson
      end

    end
  end
end
