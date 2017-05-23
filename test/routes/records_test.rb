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

    test 'records show routes with query strings' do
      content = 'v=spf1 ip4:210.188.199.71  ~all'
      type = 'txt'
      extras = { type: type, content: content }

      expected_path = '/domains/foo.com/records/www.foo.com'
      options = {
        controller: 'pdns/records',
        action: 'show',
        domain_id: 'foo.com',
        id: 'www.foo.com'
      }
      assert_generates(expected_path, options, extras)

      expected_options = {
        controller: 'pdns/records',
        action: 'show',
        domain_id: 'foo.com',
        id: 'www.foo.com',
        type: type,
        content: content
      }
      path = '/domains/foo.com/records/www.foo.com'
      assert_recognizes(expected_options, path, extras)

      expected_path = '/domains/foo.com/records/www.foo.com'
      options = {
        controller: 'pdns/records',
        action: 'show',
        domain_id: 'foo.com',
        id: 'www.foo.com'
      }
      assert_routing(expected_path, options, extras)
    end

    test 'records show routes include underscore' do
      content = 'root.foo.com. admin.foo.com. 2003068934 60 3600 1209600 86400'
      type = 'soa'
      extras = { type: type, content: content }

      expected_path = '/domains/foo.com/records/a_a.foo.com'
      options = {
        controller: 'pdns/records',
        action: 'show',
        domain_id: 'foo.com',
        id: 'a_a.foo.com'
      }
      assert_generates(expected_path, options, extras)

      expected_options = {
        controller: 'pdns/records',
        action: 'show',
        domain_id: 'foo.com',
        id: 'a_a.foo.com',
        type: type,
        content: content
      }
      path = '/domains/foo.com/records/a_a.foo.com'
      assert_recognizes(expected_options, path, extras)

      expected_path = '/domains/foo.com/records/a_a.foo.com'
      options = {
        controller: 'pdns/records',
        action: 'show',
        domain_id: 'foo.com',
        id: 'a_a.foo.com'
      }
      assert_routing(expected_path, options, extras)
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
