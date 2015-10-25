require 'test_helper'

class ActiveAuditTest < ActiveSupport::TestCase
  test "truth" do
    assert_kind_of Module, ActiveAudit
  end
end
