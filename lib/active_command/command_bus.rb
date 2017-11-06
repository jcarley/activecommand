module ActiveCommand
  class CommandBus
    include Singleton

    def self.execute(command)
      bus = self.instance
      bus.execute(command)
    end

    def execute(command)
      env = {:command => command, :at => :later}
      default_middleware.call(env)
      env[:command_result]
    end

    def self.execute_now(command)
      bus = self.instance
      bus.execute_now(command)
    end

    def execute_now(command)
      env = {:command => command, :at => :now}
      default_middleware.call(env)
      env[:command_result]
    end

    private

    def default_middleware
      @stack ||= Middleware::Builder.new do
        # use ActiveCommand::Middleware::Benchmarker
        use ActiveCommand::CommandLogger
        use ActiveCommand::CommandRunner
      end
      @stack
    end

  end
end

