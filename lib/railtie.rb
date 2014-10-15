require "rails"

module SchemalessField
  class Railtie < Rails::Railtie # :nodoc:
    initializer "schemaless_field.initialize" do |app|
      ActiveSupport.on_load(:active_record) do
        include SchemalessField::DSL
      end

      ActiveSupport.on_load(:mongoid) do
        raise "You do not need schemaless_field with mongoid."
      end
    end
  end
end
