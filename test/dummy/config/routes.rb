Rails.application.routes.draw do

  mount ActiveAudit::Engine => "/active_audit"
end
