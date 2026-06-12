# frozen_string_literal: true

module RubyUI
  class Textarea < Base
    def view_template(&)
      textarea(class: "form-input", **attrs.except(:class), &)
    end
  end
end
