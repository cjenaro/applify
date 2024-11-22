import { Controller } from "@hotwired/stimulus"

function debounce(fn, delay) {
  let timeout;
  return (...args) => {
    clearTimeout(timeout)
    timeout = setTimeout(() => fn(...args), delay)
  }
}

export default class extends Controller {
  static targets = ["url", "position", "company", "description", "aibtn", "submit", "disabler"]
  connect() {
    this.csrf = document.querySelector('meta[name="csrf-token"]').getAttribute("content");
  }

  handleUrlInput() {
    this.disableTargets()
    fetch("/job_scraper/scrape", { method: "POST", headers: { "X-CSRF-Token": this.csrf, "Content-Type": "application/json" }, body: JSON.stringify({ url: this.urlTarget.value }) })
      .then((blob) => blob.text())
      .then((html) => Turbo.renderStreamMessage(html))
      .catch(() => this.disableTargets(false))
  }

  showAIBtn() {
    this.aibtnTarget.classList.remove("hidden")
  }

  disableTargets(disable = true) {
    this.disablerTarget.disabled = disable
    this.aibtnTarget.disabled = disable
    this.submitTarget.disabled = disable
    this.urlTarget.disabled = disable
    this.positionTarget.disabled = disable
    this.companyTarget.disabled = disable
    this.descriptionTarget.disabled = disable
  }
}
