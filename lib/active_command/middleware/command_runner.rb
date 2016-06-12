module ActiveCommand
  class CommandRunner

    class MissingCommandError < StandardError; end;

    def initialize(app)
      @app = app
    end

    def call(env)

      at = env.fetch(:at, :later)
      cmd = env.fetch(:command, nil)

      result = CommandResult.new(cmd).tap do |cr|
        begin
          raise MissingCommandError if cr.command.nil?
          cr.command.run if at == :later
          cr.command.perform_now if at == :now
        rescue StandardError => e
          cr.error = e
        end
      end

      env[:command_result] = result

      @app.call(env) if @app
    end

  end
end
