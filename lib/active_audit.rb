require "active_audit/engine"

module ActiveAudit

  autoload :Models, 'active_audit/models'

  module Rules
    autoload :Base, 'active_audit/rules/base'
  end
end

require "active_audit/orm/active_record"
