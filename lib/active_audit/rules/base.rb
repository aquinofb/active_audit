module ActiveAudit
  module Rules
    module Base

      def attributes(*attrs_list)
        attrs = attrs_list
      end

      def required_attributes(*attrs_list)
        required_attrs = attrs_list
      end

      def when_the(attr, opts={}, &handler)
        rules << create_rule_for(attr, opts, &handler)
      end

      def add_hook(name, *opts)
        hooks << {:"#{name}" => opts}
      end

      def each_hook(&block)
        hooks.each do |hook|
          yield(hook.keys.first, hook.values.first)
        end
      end

      private
        def required_attrs
          @required_attrs ||= []
          @required_attrs
        end

        def attrs
          @attrs ||= []
          @attrs
        end

        def hooks
          @hooks ||= []
          @hooks
        end

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
