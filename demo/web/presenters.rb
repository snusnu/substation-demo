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

      protected

      attr_reader :data

      class Collection < self

        def self.member(presenter = Undefined)
          return @member if presenter.equal?(Undefined)
          @member = presenter
        end

        alias_method :entries, :data

        protected :entries

        def each
          return to_enum unless block_given?
          entries.each { |entry| yield self.class.member.new(entry) }
          self
        end
      end
    end
  end
end

Dir[Pathname(File.dirname(__FILE__)).join('presenters/**/*.rb')].each do |file|
  require file
end
