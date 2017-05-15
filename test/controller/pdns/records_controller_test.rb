require 'test_helper'

module PDNS
  class RecordsControllerTest < ActionController::TestCase
    setup do
      @routes = Engine.routes
    end

    test 'records index when record exists' do
      domain = Domain.new(name: 'foo.com', type: 'NATIVE')
      domain.save

      Record.new(
        domain_id: domain.id,
        name: 'www.foo.com',
        type: 'A',
        content: '172.0.0.1',
        ttl: 3600
      ).save
      Record.new(
        domain_id: domain.id,
        name: 'app.foo.com',
        type: 'CNAME',
        content: 'foo.google.com',
        ttl: 3600
      ).save

      get :index, params: { domain_id: 'foo.com' }
      assert_equal 200, response.status

      records = JSON.parse(response.body)
      assert_equal 2, records.length
      assert_equal 'www.foo.com', records.first['name']
      assert_equal 'app.foo.com', records.last['name']
    end

    test 'records index when record not exists' do
      Domain.new(name: 'foo.com', type: 'NATIVE').save

      get :index, params: { domain_id: 'foo.com' }
      assert_equal 200, response.status

      body = JSON.parse(response.body)
      assert_equal [], body
    end

    test 'records show when valid' do
      domain = Domain.new(name: 'foo.com', type: 'NATIVE')
      domain.save
      Record.new(
        domain_id: domain.id,
        name: 'www.foo.com',
        type: 'A',
        content: '172.0.0.1',
        ttl: 3600
      ).save

      get :show, params: { domain_id: 'foo.com', id: 'www.foo.com' }
      assert_equal 200, response.status

      record = JSON.parse(response.body)
      assert_equal %w(id domain_id name type content ttl prio
        change_date disabled ordername auth), record.keys

      assert_equal domain.id, record['domain_id']
      assert_equal 'www.foo.com', record['name']
      assert_equal 'A', record['type']
      assert_equal 3600, record['ttl']
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
