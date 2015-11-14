module ActiveCommand
  class CommandResult

    attr_accessor :command, :error

    def initialize(command)
      @command = command
    end

    def success?
      self.error.nil?
    end
    alias_method :is_successful?, :success?

  end
end
