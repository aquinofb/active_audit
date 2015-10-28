module ActiveAudit
  module Rules
    module Base

      def attributes(*attrs_list)
        self.module_eval do
          mattr_accessor :attrs
        end

        self.attrs = attrs_list
      end

      def required_attributes(*attrs_list)
        self.module_eval do
          mattr_accessor :required_attrs
        end

        self.required_attrs = attrs_list
      end

      def when_the(attr, opts={}, &handler)
        create_hook_for(attr, opts, &handler)
      end

      def add_hook(name, *opts)
        hooks << {:"#{name}" => opts}
      end

      def each_hook(&block)
        hooks.each do |hook|
          yield(hook.keys.first, hook.values.first)
        end
      end

      def validate_json!(data)
        valid_attributes?(data) && valid?(data)
      end

      private
        def valid_attributes?(data)
          raise "Invalid attributes: #{(data.keys - attrs).join(", ")}" unless attrs.sort.eql?(data.keys.sort)
        end

        def valid?(data)
          required_attrs.each do |required|
            raise "Invalid json. Attribute #{required} is required" unless data.keys.include?(required) && data[required].present?
          end
        end

        def hooks
          @hooks ||= []
          @hooks
        end

        def create_hook_for(attr, opts, &handler)
          add_hook :before_save, opts[:do], if: handler || Proc.new { |resource|
            if opts[:if] then next(false) unless resource.send(opts[:if]) end

            if resource.send(:"#{attr}_changed?")
              its_ok, from, to = true, opts[:change_from], (opts[:change_to] || opts[:to])
              its_ok = resource.send(:"#{attr}_was").eql?(from) if from
              its_ok = resource.send(:"#{attr}").eql?(to) if to
              its_ok
            end
          }
        end
    end
  end
end
