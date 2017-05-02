require 'test_helper'

module PDNS
  class RecordTest < ActiveSupport::TestCase
    setup do
      @domain = Domain.new(name: 'example.com')
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
  end
end
