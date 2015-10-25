module ActiveAudit
  module Rules
    module Base

      def when_the(attr, opts={}, &handler)
        rules << create_rule_for(attr, opts, &handler)
      end

      def add_hook name, *opts
        hooks << {:"#{name}" => opts}
      end

      def hooks
        @hooks ||= []
        @hooks
      end

      private
        def rules
          @rules ||= []
          @rules
        end

        def create_rule_for(attr, opts, &handler)
          rule = {}
          rule[attr] = {}
          rule[attr][:previous_state] = opts[:change_from]
          rule[attr][:current_state] = opts[:change_to] || opts[:to]
          rule[attr][:do] = opts[:do] || handler
          rule[attr][:if] = opts[:if]
          rule
        end
    end
  end
end
