module ActiveAudit
  module Models
    extend ActiveSupport::Concern
    @@configured_modules = []

    def self.config_module mod
      return if @@configured_modules.include?(mod)

      mod.module_eval do
        def self.included(base)
          self.each_hook do |hook_name, options|
            base.send(hook_name, *options)
          end
        end
      end

      @@configured_modules << mod
    end

    class_methods do
      def active_audit_by mod
        my_mod = "#{mod}_active_audit".to_s.classify.constantize
        ActiveAudit::Models.config_module(my_mod)
        self.include(my_mod)
      end
    end
  end
end
