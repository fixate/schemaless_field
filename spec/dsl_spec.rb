require 'spec_helper'

class Dummy
  attr_accessor :data
  include SchemalessField::DSL

  def initialize
    self.data = {
      'lannisters' => {
        'geoffrey' => 'king',
        'cersei' => 'queen regent',
        'tyrion' => 'master of coin'
      },
      'places' => [
        { 'name' => 'kings landing', 'region' => 'Crownlands' }
      ],
      'kings' => [
        'Geoffrey',
        'Robert',
        'Stannis',
        'Renly',
        'Tommen'
      ],
      'assign' => {
        'me' => nil
      }
    }
  end
end

RSpec.describe SchemalessField::DSL do
  before :all do
    Dummy.schemaless_field :data do |f|
      f.field :lannisters
      f.field :first_king, '$..kings[0]'
      f.field :lannisters_tyrion
      f.field :not_real
      f.field :kings_landing, '$..places[?@.name=="kings landing"].region'
      f.field :assign_me
    end
  end

  subject { Dummy.new }

  it 'retreives correct values' do
    expect(subject.lannisters).to eq(subject.data['lannisters'])
  end

  it 'retrieves values from json path' do
    expect(subject.first_king).to eq(subject.data['kings'].first)
  end

  it 'inferes path from name' do
    expect(subject.lannisters_tyrion).to eq(subject.data['lannisters']['tyrion'])
  end

  it 'returns nil for non-existant values' do
    expect(subject.not_real).to be_nil
  end

  it 'allows you to assign values' do
    subject.assign_me = '123'
    expect(subject.assign_me).to eq('123')
    expect(subject.data['assign']['me']).to eq('123')
  end
end

