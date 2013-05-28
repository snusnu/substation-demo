class Demo
  module Actions

    class CreatePerson < Demo::Action
      def initialize(request)
        super
        @person = request.input
      end

      def call
        db.insert_person(@person)
        success(@person)
      end
    end
  end
end
