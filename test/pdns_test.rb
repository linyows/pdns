require 'test_helper'

class PDNS::Test < ActiveSupport::TestCase
  test "truth" do
    assert_kind_of Module, PDNS
  end

  test "domain format" do
    assert_equal PDNS.domain_format, /\A[^-][a-z0-9\-\._]*[^-]\.[a-z0-9-]{2,}\Z/
  end

  test "domain format for routes" do
    assert_equal PDNS.domain_format_for_routes, /[a-z0-9\-\._]*\.[a-z0-9-]{2,}/
  end

  test "db name" do
    assert_equal PDNS.db_name, :pdns
  end

  test "db conf path" do
    assert_equal PDNS.db_conf_path, "config/database-pdns.yml"
  end

  test "db dir path" do
    assert_equal PDNS.db_dir_path, File.expand_path('../../db', __FILE__)
  end
end
