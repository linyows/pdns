require 'test_helper'

class PDNS::Test < ActiveSupport::TestCase
  test "truth" do
    assert_kind_of Module, PDNS
  end

  test "domain format" do
    assert_equal /\A[^-][a-z0-9\-\._]*[^-]\.[a-z0-9-]{2,}\Z/, PDNS.domain_format
  end

  test "domain format for routes" do
    assert_equal /[a-z0-9\-\._]*\.[a-z0-9-]{2,}/, PDNS.domain_format_for_routes
  end

  test "db name" do
    assert_equal :pdns, PDNS.db_name
  end

  test "db conf path" do
    assert_equal "config/database-pdns.yml", PDNS.db_conf_path
  end

  test "db dir path" do
    assert_equal File.expand_path('../../db', __FILE__), PDNS.db_dir_path
  end

  test 'domain_as_json' do
    assert_not PDNS.domain_as_json
  end

  test 'record_as_json' do
    assert_not PDNS.record_as_json
  end

  test 'db conf' do
    expected = {"sqlite"=>{"adapter"=>"sqlite3", "database"=>"db/development.sqlite3"}, "mysql"=>{"adapter"=>"mysql2", "username"=>"root", "host"=>"localhost", "password"=>nil, "database"=>"pdns_development", "encoding"=>"utf8"}, "postgresql"=>{"pool"=>16, "timeout"=>5000, "adapter"=>"postgresql", "encoding"=>"unicode", "username"=>"postgres", "password"=>nil, "database"=>"pdns_development", "min_messages"=>"ERROR"}, "default"=>{"adapter"=>"mysql2", "username"=>"root", "host"=>"localhost", "password"=>nil, "database"=>"pdns_development", "encoding"=>"utf8"}, "development"=>{"adapter"=>"mysql2", "username"=>"root", "host"=>"localhost", "password"=>nil, "database"=>"pdns_development", "encoding"=>"utf8"}, "test"=>{"adapter"=>"mysql2", "username"=>"root", "host"=>"localhost", "password"=>nil, "database"=>"pdns_test", "encoding"=>"utf8"}, "production"=>{"adapter"=>"mysql2", "username"=>nil, "host"=>nil, "password"=>nil, "database"=>"pdns", "encoding"=>"utf8"}}
    assert_equal expected, PDNS.db_conf
  end
end
