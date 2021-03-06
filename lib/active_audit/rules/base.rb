module ActiveAudit
  module Rules
    module Base

      def attributes(*attrs_list)
        self.module_eval {mattr_accessor(:attrs)}
        self.attrs = attrs_list
      end

      def required_attributes(*attrs_list)
        self.module_eval {mattr_accessor(:required_attrs)}
        self.required_attrs = attrs_list
      end

      def when_the(attr, opts={}, &handler)
        create_hook_for(attr, opts, &handler)
      end

      def add_hook(name, *opts)
        self.module_eval {mattr_accessor(:hooks)} unless self.respond_to?(:hooks)
        self.hooks << {:"#{name}" => opts}
      end

      def each_hook(&block)
        self.hooks.each do |hook|
          yield(hook.keys.first, hook.values.first)
        end
      end

      def validate_json!(data)
        data.symbolize_keys!
        raise "Invalid attributes. Missing attributes: #{(self.attrs - data.keys).join(", ")}" unless valid_attributes?(data)
        raise "Invalid json. Attribute #{required} is required" unless valid?(data)
      end

      private
        def valid_attributes?(data)
          self.attrs.sort.eql?(data.keys.sort)
        end

        def valid?(data)
          self.required_attrs.each do |required|
            return false unless data.keys.include?(required) && data[required].present?
          end
          true
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
