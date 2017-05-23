require 'test_helper'

module PDNS
  class RecordsRouteTest < ActionController::TestCase
    setup do
      @routes = Engine.routes
    end

    test 'records index routes' do
      assert_generates '/domains/foo.com/records',
        controller: 'pdns/records', action: 'index', domain_id: 'foo.com'
      assert_recognizes({ controller: 'pdns/records', action: 'index', domain_id: 'foo.com' },
        { path: 'domains/foo.com/records', method: :get })
      assert_routing '/domains/foo.com/records',
        controller: 'pdns/records', action: 'index', domain_id: 'foo.com'
    end

    test 'records create routes' do
      assert_generates '/domains/foo.com/records',
        controller: 'pdns/records', action: 'create', domain_id: 'foo.com'
      assert_recognizes({ controller: 'pdns/records', action: 'create', domain_id: 'foo.com' },
        { path: 'domains/foo.com/records', method: :post })
      assert_routing({ method: :post, path: '/domains/foo.com/records' },
        { controller: 'pdns/records', action: 'create', domain_id: 'foo.com' })
    end

    test 'records show routes' do
      assert_generates '/domains/foo.com/records/www.foo.com',
        controller: 'pdns/records', action: 'show', domain_id: 'foo.com', id: 'www.foo.com'
      assert_recognizes({ controller: 'pdns/records', action: 'show', domain_id: 'foo.com', id: 'www.foo.com' },
        { path: '/domains/foo.com/records/www.foo.com', method: :get })
      assert_routing '/domains/foo.com/records/www.foo.com',
        controller: 'pdns/records', action: 'show', domain_id: 'foo.com', id: 'www.foo.com'
    end

    test 'records destroy routes' do
      assert_generates '/domains/foo.com/records/www.foo.com',
        controller: 'pdns/records', action: 'destroy', domain_id: 'foo.com', id: 'www.foo.com'
      assert_recognizes({ controller: 'pdns/records', action: 'destroy', domain_id: 'foo.com', id: 'www.foo.com' },
        { path: 'domains/foo.com/records/www.foo.com', method: :delete })
      assert_routing({ method: :delete, path: '/domains/foo.com/records/www.foo.com' },
        { controller: 'pdns/records', action: 'destroy', domain_id: 'foo.com', id: 'www.foo.com' })
    end
  end
end
