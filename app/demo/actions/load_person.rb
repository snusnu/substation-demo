class Demo
  module Actions

    class LoadPerson < Demo::Action
      def initialize(request)
        super
        @id = request.input
      end

      def call
        success(db.load_person(@id))
      end
    end
  end
end
