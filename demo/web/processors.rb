class Demo
  module Web

    class Serializer
      include Substation::Processor::Outgoing

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

        MODEL  = Model.new
        CUSTOM = Custom.new
      end
    end

    class Renderer
      include Substation::Processor::Outgoing
      include Concord.new(:handler)

      def call(response)
        respond_with(response, Mustache.render(handler, response.output))
      end
    end

  end
end
