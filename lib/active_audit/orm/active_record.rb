require 'active_record'

ActiveRecord::Base.send :include, ActiveAudit::Models
