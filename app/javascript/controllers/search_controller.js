import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="search"
export default class extends Controller {
  static targets = [ "query" ,"load"]
  connect() {
    console.log("connected to stimulus")
  }

  submit(e){
    e.preventDefault()
    fetch(`/search?query=${this.queryTarget.value}`).then((response) => response.text())
    .then((html) => {
      this.loadTarget.innerHTML = html;
    })
  }
}
