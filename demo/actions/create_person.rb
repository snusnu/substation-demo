class Demo
  module Actions

    class CreatePerson < Demo::Action
      def initialize(request)
        super
        @person = request.input
      end

      def call
        success(db.insert_person(@person))
      end
    end
  end
end
