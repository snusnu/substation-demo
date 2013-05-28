class Demo
  module Web

    class Processor
      include AbstractType
      include Equalizer.new(:handler)
      include Adamantium::Flat

      def initialize(handler = nil)
        @handler = handler
      end

      abstract_method :call
      abstract_method :result

      protected

      attr_reader :handler

      class Incoming < self
        include Substation::Chain::Incoming
      end

      class Outgoing < self
        include Substation::Chain::Outgoing

        private

        def respond_with(response, output)
          response.class.new(response.request, output)
        end
      end
    end

    class Sanitizer < Processor::Incoming
      def call(request)
        result = handler.run(request.input)
        if result.successful?
          request.success(result.output)
        else
          request.error(result.output.pretty_dump)
        end
      end
    end

    class Validator < Processor::Incoming
      def call(request)
        result = handler.call(request.input)
        if result.valid?
          request.success(request.input)
        else
          request.error(result.violations)
        end
      end
    end

    class Pivot < Processor
      include Substation::Chain::Pivot

      def call(request)
        handler.call(request)
      end
    end

    class Wrapper < Processor::Outgoing
      def call(response)
        respond_with(response, handler.new(response.output))
      end
    end

    class Serializer < Processor::Outgoing
      module JSON

        class Model < Serializer
          def call(response)
            output = response.output
            data   = output.class.attributes_hash(output)

            respond_with(response, MultiJson.dump(data))
          end
        end

        class Custom < Serializer
          def call(response)
            respond_with(response, handler.new(response.output).to_json)
          end
        end
      end
    end

    class Renderer < Processor::Outgoing

      def call(response)
        respond_with(response, Mustache.render(handler, response.output))
      end
    end
  end
end
