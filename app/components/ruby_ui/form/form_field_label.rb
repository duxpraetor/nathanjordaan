# frozen_string_literal: true

module RubyUI
  class FormFieldLabel < Base
    def view_template(&)
      label(class: "form-label", **attrs.except(:class), &)
    end
  end
end
