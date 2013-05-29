class Demo

  module Models

    class Person
      include Anima.new(:id, :name)
      include Anima::Update
    end
  end
end
