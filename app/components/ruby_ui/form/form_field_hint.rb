# frozen_string_literal: true

module RubyUI
  class FormFieldHint < Base
    def view_template(&)
      p(class: "form-hint", **attrs.except(:class), &)
    end
  end
end
