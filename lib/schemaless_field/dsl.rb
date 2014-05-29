module SchemalessField
  module DSL
    def self.included(base)
      base.class_eval do
        def self.json_attr(attr)
          yield Field.new(self, attr)
        end
      end
    end
  end
end
