require 'jsonpath'
require 'json'

require "schemaless_field/version"
require 'schemaless_field/dsl'
require 'schemaless_field/field'

require 'active_support/core_ext/hash'

require 'railtie' if defined?(Rails)

module SchemalessField
  def self.eager_load!

  end
end
