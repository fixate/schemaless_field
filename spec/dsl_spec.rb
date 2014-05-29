require 'spec_helper'

class Dummy
  attr_accessor :data
  include SchemalessField::DSL

  def initialize
    self.data = {
      lannisters: {
        geoffrey: 'king',
        cersei: 'queen regent',
        tyrion: 'master of coin'
      }
    }
  end
end

describe SchemalessField::DSL do
  it 'creates and yields a new field' do
    Dummy.json_attr :data do |f|
      f.field :lannisters
    end

    dummy = Dummy.new
    expect(dummy.lannisters).to eq(dummy.data['lannisters'])
  end
end

