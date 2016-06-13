module ActiveCommand
  class Command
    include Core
    include Sidekiq::Worker
    include Virtus.model
    include ActiveModel::Validations
    include ActiveModel::Serializers::JSON

    attribute :job_id, String

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
      self.class.perform_async self.to_params.to_json
    end

    def perform(job_data)
      self.from_json(job_data)
      self.perform_now
    end

    def perform_now
      if self.valid?
        self.execute
      else
        raise ActiveCommand::CommandNotValidError, self.errors.full_messages
      end
    end

    def execute
      raise NotImplementedError, "#{self.class.name} does not implement an execute method"
    end

  end
end
