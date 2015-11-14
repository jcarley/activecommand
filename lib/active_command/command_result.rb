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

    def on_success?(&block)
      if self.is_successful?
        block.call(self)
      end
      self
    end

    def on_error?(&block)
      if ! self.is_successful?
        block.call(self)
      end
      self
    end
  end
end
