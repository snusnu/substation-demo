class Demo
  module Actions

    class ListPeople < Demo::Action
      def call
        success(db.list_people)
      end
    end
  end
end
