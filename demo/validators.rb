class Demo

  module Validators

    NEW_PERSON = Vanguard::Validator.build do
      validates_presence_of :name
    end

    PERSON = Vanguard::Validator.build do
      validates_presence_of :id
      validates_presence_of :name
    end
  end
end
