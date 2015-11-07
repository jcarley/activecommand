module ActiveCommand
  class Command
    include Virtus.model
    include ActiveModel::Validations
    include ActiveModel::Serializers::JSON

    def self.from_json(json)
      klass = self.new
      klass.from_json(json)
      klass
    end

    def to_params
      ActiveSupport::HashWithIndifferentAccess.new(attributes).delete_if { |k, v| v.nil? }
    end
    alias_method :to_hash, :to_params

    def run
      if self.valid?
        self.execute
      else
        raise ActiveCommand::CommandNotValidError
      end
    end

    def execute
      raise NotImplementedError
    end

  end
end
