import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ['filterForm', 'filterTerm']

  filter() {
    this.filterFormTarget.requestSubmit()
  }
}
