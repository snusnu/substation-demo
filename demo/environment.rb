class Demo

  class Environment
    include Concord.new(:storage)

    # The storage abstraction
    #
    # @return [Storage]
    #
    # @api private
    attr_reader :storage
  end
end
