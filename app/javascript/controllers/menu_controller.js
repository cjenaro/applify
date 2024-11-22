
import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["button", "menu"];

  connect() {
    this.closeMenu();
    document.addEventListener("click", this.handleOutsideClick.bind(this));
    document.addEventListener("keydown", this.handleEscapeKey.bind(this));
  }

  disconnect() {
    document.removeEventListener("click", this.handleOutsideClick.bind(this));
    document.removeEventListener("keydown", this.handleEscapeKey.bind(this));
  }

  toggleMenu(event) {
    event.stopPropagation();
    if (this.menuTarget.classList.contains("opacity-0")) {
      this.openMenu();
    } else {
      this.closeMenu();
    }
  }

  openMenu() {
    this.menuTarget.classList.remove("opacity-0", "scale-95", "pointer-events-none");
    this.menuTarget.classList.add("opacity-100", "scale-100");
    this.buttonTarget.setAttribute("aria-expanded", "true");
  }

  closeMenu() {
    this.menuTarget.classList.add("opacity-0", "scale-95", "pointer-events-none");
    this.menuTarget.classList.remove("opacity-100", "scale-100");
    this.buttonTarget.setAttribute("aria-expanded", "false");
  }

  handleOutsideClick(event) {
    if (!this.element.contains(event.target)) {
      this.closeMenu();
    }
  }

  handleEscapeKey(event) {
    if (event.key === "Escape") {
      this.closeMenu();
    }
  }
}

