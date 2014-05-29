require 'spec_helper'

class Dummy
  attr_accessor :data

  def initialize
    self.data = {
      foo: [1,2,3],
      bar: '!!!',
      nested: {
        quite: 'deep'
      }
    }
  end
end

describe SchemalessField::Field do
  subject { Dummy.new }
  let(:field) { described_class.new(subject.class, :data) }

  before { field.field :foo, '$..foo' }

  it 'defines getter method on the model' do
    expect(subject).to respond_to(:foo)
  end

  it 'defines getter method on the model' do
    expect(subject).to respond_to(:"foo=")
  end

  it 'raises error if class does not have attribute' do
    expect {
      described_class.new(Dummy, :not_very_existing)
    }.to raise_error
  end

  it 'returns nil if path doesnt exist' do
    field.field :not_existing_path
    expect(subject.not_existing_path).to be_nil
  end

  describe 'implicit path' do
    before { field.field :nested_quite }
    it 'finds field implicitly' do
      expect(subject.nested_quite).to eq('deep')
    end
  end

  describe 'getter' do
    it 'gets data from the json' do
      expect(subject.foo).to eq([1,2,3])
    end

    it 'gets deep data in json' do
      field.field :nested_deep, '$..nested.quite'
      expect(subject.nested_deep).to eq('deep')
    end
  end

  describe 'setter' do
    it 'sets data in json' do
      subject.foo = 'haldo'
      expect(subject.data['foo']).to eq('haldo')
    end

    it 'sets deep data in json' do
      field.field :nested_deep, '$..nested.quite'
      subject.nested_deep = 'shallow'
      expect(subject.data['nested']['quite']).to eq('shallow')
    end
  end
end
