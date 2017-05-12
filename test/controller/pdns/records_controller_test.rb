require 'test_helper'

module PDNS
  class RecordsControllerTest < ActionController::TestCase
    setup do
      @routes = Engine.routes
    end

    test 'records show when valid' do
      domain = Domain.new(name: 'foo.com', type: 'NATIVE')
      domain.save
      Record.new(
        domain_id: domain.id,
        name: 'www.foo.com',
        type: 'CNAME',
        content: '172.0.0.1',
        ttl: 3600
      ).save

      get :show, params: { domain_id: 'foo.com', id: 'www.foo.com' }
      assert_equal 200, response.status

      record = JSON.parse(response.body)
      assert_equal record.keys, %w(id domain_id name type content ttl prio
                                   change_date disabled ordername auth)

      assert_equal record['domain_id'], domain.id
      assert_equal record['name'], 'www.foo.com'
      assert_equal record['type'], 'CNAME'
      assert_equal record['ttl'], 3600
      assert_nil record['prio']
      assert_not record['disabled']
      assert_nil record['ordername']
      assert record['auth']
    end

    test 'records show when not found' do
      assert_raises ActiveRecord::RecordNotFound do
        get :show, params: { domain_id: 'foo.com', id: 'www.foo.com' }
      end
    end

    test 'records show when invalid id' do
      assert_raises ActionController::UrlGenerationError do
        get :show, params: { domain_id: 'foo.com', id: '//www.foo.com' }
      end
    end
  end
end
