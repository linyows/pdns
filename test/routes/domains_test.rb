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

    test 'domains create routes' do
      assert_generates '/domains', controller: 'pdns/domains', action: 'create'
      assert_recognizes({ controller: 'pdns/domains', action: 'create' }, { path: 'domains', method: :post })
      assert_routing({ method: :post, path: '/domains' }, { controller: 'pdns/domains', action: 'create' })
    end

    test 'domains show routes' do
      assert_generates '/domains/foo.com', controller: 'pdns/domains', action: 'show', id: 'foo.com'
      assert_recognizes({ controller: 'pdns/domains', action: 'show', id: 'foo.com' }, { path: 'domains/foo.com', method: :get })
      assert_routing '/domains/foo.com', controller: 'pdns/domains', action: 'show', id: 'foo.com'
    end

    test 'domains destroy routes' do
      assert_generates '/domains/foo.com', controller: 'pdns/domains', action: 'destroy', id: 'foo.com'
      assert_recognizes({ controller: 'pdns/domains', action: 'destroy', id: 'foo.com' }, { path: 'domains/foo.com', method: :delete })
      assert_routing({ method: :delete, path: '/domains/foo.com' }, { controller: 'pdns/domains', action: 'destroy', id: 'foo.com' })
    end
  end
end
