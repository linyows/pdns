require 'test_helper'

module PDNS
  class DomainsRouteTest < ActionController::TestCase
    setup do
      @routes = Engine.routes
    end

    test 'domains index routes' do
      assert_generates '/domains', controller: 'pdns/domains', action: 'index'
      assert_recognizes({ controller: 'pdns/domains', action: 'index' }, { path: 'domains', method: :get })
      assert_routing '/domains', controller: 'pdns/domains', action: 'index'
    end
  end
end
