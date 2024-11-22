import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="header"
export default class extends Controller {
  static targets = ["show-menu", "hide-menu", "mobile-menu"]
  connect() {
    this.closeMenu()
  }

  toggleMenu() {
    const isClosed = this["mobile-menuTarget"].classList.contains("hidden")
    if (isClosed) {
      this.openMenu()
    } else {
      this.closeMenu()
    }
  }

  openMenu() {
    this["show-menuTarget"].classList.add("hidden")
    this["hide-menuTarget"].classList.remove("hidden")
    this["mobile-menuTarget"].classList.remove("hidden")
  }
  closeMenu() {
    this["show-menuTarget"].classList.remove("hidden")
    this["hide-menuTarget"].classList.add("hidden")
    this["mobile-menuTarget"].classList.add("hidden")
  }
}
