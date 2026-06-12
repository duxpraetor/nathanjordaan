import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["item"]

  connect() {
    const viewportBottom = window.innerHeight
    let staggerIndex = 0

    this.itemTargets.forEach((el) => {
      const rect = el.getBoundingClientRect()

      // Only stagger items already visible on page load
      if (rect.top < viewportBottom && !el.classList.contains("is-visible")) {
        el.style.setProperty("--reveal-delay", `${staggerIndex * 100}ms`)
        staggerIndex++
      }
    })

    // Lift the flash guard now that delays are set and observer is ready
    this.element.removeAttribute("data-reveal-hidden")

    this.observer = new IntersectionObserver(
      (entries) => {
        entries.forEach((entry) => {
          if (entry.isIntersecting) {
            entry.target.classList.add("is-visible")
            this.observer.unobserve(entry.target)
          }
        })
      },
      { rootMargin: "0px 0px -8% 0px", threshold: 0.1 }
    )

    this.itemTargets.forEach((el) => this.observer.observe(el))
  }

  disconnect() {
    this.observer.disconnect()
  }
}
