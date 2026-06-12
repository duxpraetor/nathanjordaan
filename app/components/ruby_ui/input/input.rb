# frozen_string_literal: true

module RubyUI
  class Input < Base
    def initialize(type: :text, **attrs)
      @type = type.to_sym
      super(**attrs)
    end

    def view_template
      input(type: @type, class: "form-input", **attrs.except(:class))
    end
  end
end
