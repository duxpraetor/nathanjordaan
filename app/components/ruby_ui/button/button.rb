# frozen_string_literal: true

module RubyUI
  class Button < Base
    def initialize(variant: :primary, **attrs)
      @variant = variant.to_sym
      super(**attrs)
    end

    def view_template(&)
      if @variant == :outline
        button(class: "btn btn-outline", **attrs.except(:class), &)
      else
        button(class: "btn", **attrs.except(:class), &)
      end
    end
  end
end
