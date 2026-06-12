# frozen_string_literal: true

module RubyUI
  class FormField < Base
    def view_template(&)
      div(class: "form-field", **attrs.except(:class), &)
    end
  end
end
