class Demo
  module Actions

    class NewPerson < Demo::Action
      def call
        success(Models::Person.new(:id => 1, :name => 'Dummy'))
      end
    end
  end
end
