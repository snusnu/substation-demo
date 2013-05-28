class Demo

  module Validators

    NEW_PERSON = Aequitas::Validator.build do
      validates_presence_of :name
    end
  end
end
