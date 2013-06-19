class Demo
  module Web

    module Actions

      AUTHENTICATED = Web::ENV.chain do
        use Authenticator::INSTANCE
      end

      AUTHORIZED = Web::ENV.chain(AUTHENTICATED) do
        use Authorizer::INSTANCE
      end

      # -------------------------------------------

      LIST_PEOPLE = Web::ENV.chain do
        call Demo::Actions::ListPeople
      end

      NEW_PERSON = Web::ENV.chain(AUTHORIZED) do
        call Demo::Actions::NewPerson
      end

      LOAD_PERSON = Web::ENV.chain do
        evaluate Sanitizers::LOAD_PERSON

        call Demo::Actions::LoadPerson
      end

      CREATE_PERSON = Web::ENV.chain(AUTHORIZED) do
        evaluate Sanitizers::NEW_PERSON
        evaluate Demo::Validators::NEW_PERSON

        call Demo::Actions::CreatePerson
      end

    end
  end
end
