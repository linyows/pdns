require 'test_helper'
require File.expand_path('../../../lib/generators/pdns/install_generator.rb', __FILE__)

class InstallGeneratorTest < Rails::Generators::TestCase
  tests PDNS::InstallGenerator
  destination File.expand_path('../tmp', File.dirname(__FILE__))
  setup :prepare_destination

  test 'assert all files are properly created' do
    run_generator
    assert_file 'config/initializers/pdns.rb'
    assert_file 'config/database-pdns.yml'
  end
end
