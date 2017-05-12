require 'test_helper'

module PDNS
  class RecordTest < ActiveSupport::TestCase
    setup do
      @domain = Domain.new(name: 'example.com', type: 'NATIVE')
      @domain.save
      @record = Record.new(
        domain_id: @domain.id,
        name: @domain.name,
        type: 'A',
        content: '127.0.0.1',
        ttl: 600
      )
    end

    test 'record is valid' do
      assert @record.valid?
    end

    test 'record is invalid' do
      record = Record.new
      record.valid?

      assert_includes record.errors[:domain], 'must exist'

      assert_includes record.errors[:domain_id], 'can\'t be blank'

      assert_includes record.errors[:name], 'can\'t be blank'
      assert_includes record.errors[:name], 'is invalid'

      assert_includes record.errors[:type], 'can\'t be blank'
      assert_includes record.errors[:type], 'is not included in the list'

      assert_includes record.errors[:content], 'can\'t be blank'

      assert_includes record.errors[:ttl], 'can\'t be blank'
      assert_includes record.errors[:ttl], 'is not a number'

      assert_equal record.errors.count, 9
    end

    test 'record name validation' do
      @record.name = 'example-0123456789.com'
      assert @record.valid?

      @record.name = 'xn--vck8cuc4a.jp'
      assert @record.valid?

      @record.name = 'example.co.jp'
      assert @record.valid?

      @record.name = 'www.example.com'
      assert @record.valid?

      @record.name = 'example-.com'
      assert_not @record.valid?

      @record.name = '-example.com'
      assert_not @record.valid?

      @record.name = 'サンプル.jp'
      assert_not @record.valid?

      @record.name = 'ho_ge.foo.com'
      assert @record.valid?

      @record.name = 'example.xn--tckwe'
      assert @record.valid?

      @record.name = 'xn--vck8cuc4a.xn--tckwe'
      assert @record.valid?

      @record.name = 'www.example.xn--tckwe'
      assert @record.valid?

      @record.name = 'foo.com'
      @record.save
      copy = @record.dup
      assert_not copy.valid?
      assert_includes copy.errors[:name], 'has already been taken'
    end

    test 'record ttl validation' do
      @record.ttl = 'hoge'
      assert_not @record.valid?
    end

    test 'record prio validation' do
      @record.type = 'A'
      @record.prio = 'hoge'
      assert @record.valid?

      @record.type = 'MX'
      @record.prio = 'hoge'
      assert_not @record.valid?
    end

    test 'record type validation' do
      @record.type = 'A'
      @record.prio = nil
      assert @record.valid?

      @record.type = 'MX'
      @record.prio = nil
      assert_not @record.valid?
    end

    test 'record before_update for change_date' do
      @record.save
      assert @record.change_date == nil
      @record.update_attribute(:ttl, 30)
      assert @record.change_date > 0
    end

    test 'record update_serial for soa' do
      src = 'foo.jp. bar.com. 1 7200 900 1209600 86400'
      dsc = 'foo.jp. bar.com. 2 7200 900 1209600 86400'
      soa = Record.new(
        domain_id: @domain.id,
        name: @domain.name,
        type: 'SOA',
        content: src,
        ttl: 600
      )
      soa.save
      assert_equal src, soa.content

      @record.save
      @record.update_serial
      soa.reload.content
      assert_equal dsc, soa.content
    end
  end
end
