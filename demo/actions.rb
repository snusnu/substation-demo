class Demo

  class Action

    include AbstractType

    def self.call(request)
      new(request).call
    end

    def initialize(request)
      @request = request
      @env     = @request.env
      @input   = @request.input
    end

    abstract_method :call

    private

    attr_reader :request
    attr_reader :env
    attr_reader :input

    def db
      @env.storage
    end

    def success(data)
      @request.success(data)
    end

    def error(data)
      @request.error(data)
    end
  end
end

Dir[Pathname(File.dirname(__FILE__)).join('actions/**/*.rb')].each do |file|
  require file
end
