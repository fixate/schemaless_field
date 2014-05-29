module SchemalessField
  class Field
    attr_reader :model, :model_attr

    def initialize(model, model_attr)
      @model = model
      @model_attr = model_attr

      raise RuntimeError, "#{model} does not have attribute #{model_attr}." \
        unless model.method_defined?(model_attr)
    end

    def field(attribute, path = nil)
      path ||= path_from_attr(attribute)
      mod = Module.new
      model.send(:include, mod)
      mod.class_eval <<-RUBY, __FILE__, __LINE__ + 1
        # Getter
        def #{attribute}
          ::JsonPath.on(json__#{attribute}, '#{path}')[0]
        end

        # Setter
        def #{attribute}=(value)
          self.#{@model_attr} = ::JsonPath
            .for(json__#{attribute})
            .gsub('#{path}') { |v| value }
            .to_hash
        end

        private

        def json__#{attribute}
          val = self.send(:#{@model_attr})
          case val
          when String
            val
          when Hash
            val.deep_stringify_keys
          end
        end
      RUBY
    end

    private

    def path_from_attr(attribute)
      "$..#{attribute.to_s.gsub('_', '.')}"
    rescue
      "$..#{attribute}"
    end
  end
end
