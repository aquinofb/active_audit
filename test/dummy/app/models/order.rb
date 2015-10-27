class Order < ActiveRecord::Base
  active_audit_by :aff
end
