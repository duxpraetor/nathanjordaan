# frozen_string_literal: true

module RubyUI
  class FormFieldError < Base
    def view_template(&)
      p(class: "form-error", **attrs.except(:class), &)
    end
  end
end
