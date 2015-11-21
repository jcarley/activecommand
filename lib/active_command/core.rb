module ActiveCommand
  module Core
    extend ActiveSupport::Concern

    module ClassMethods
      def set_as_background(value)
        self.include ActiveCommand::BackgroundCommand if value
      end
    end

  end
end
