import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["button"]

  disable() {
    this.buttonTarget.disabled = true
    this.buttonTarget.textContent = "Sending…"
  }
}
