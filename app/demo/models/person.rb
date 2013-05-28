class Demo

  module Models

    class Person
      include Anima.new(:id, :name)

      def self.attributes_hash(instance)
        { :id => instance.id, :name => instance.name }
      end
    end
  end
end
