module ActiveAudit
  class Rule < ActiveRecord::Base
    before_save :validate_rule_data

    def validate_rule_data
      "#{self.audit_type}_active_audit".classify.constantize.validate_json!(JSON.parse(self.data))
    end
  end
end
