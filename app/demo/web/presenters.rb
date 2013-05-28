class Demo
  module Web

    class Presenter
      include AbstractType
      include Adamantium::Flat

      def initialize(data)
        @data = data
      end

      def method_missing(method, *args, &block)
        @data.send(method, *args, &block)
      end

      def respond_to?(method)
        super || @data.respond_to?(method)
      end
    end
  end
end

Dir[Pathname(File.dirname(__FILE__)).join('presenters/**/*.rb')].each do |file|
  require file
end
