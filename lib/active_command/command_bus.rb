module ActiveCommand
  class CommandBus
    include Singleton

    def self.execute(command)
      bus = self.instance
      bus.execute(command)
    end

    def execute(command)
      env = {:command => command}
      default_middleware.call(env)
      env[:command_result]
    end

    private

    def default_middleware
      @stack ||= Middleware::Builder.new do
        # use ActiveCommand::Middleware::Benchmarker
        use ActiveCommand::CommandRunner
      end
      @stack
    end

  end
end

