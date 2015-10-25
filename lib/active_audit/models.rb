module ActiveAudit
  module Models
    extend ActiveSupport::Concern

    def self.config_module mod
      mod.extend ActiveSupport::Concern
      mod.module_eval do
        included do
          mod.hooks.each do |hook|
            self.send(hook.keys.first, *hook.values.first)
          end
        end
      end
    end

    class_methods do
      def active_audit_by mod
        my_mod = mod.to_s.classify.constantize
        ActiveAudit::Models.config_module(my_mod)
        self.include my_mod
      end
    end
  end
end
