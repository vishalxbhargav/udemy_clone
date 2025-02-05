import { Controller } from "@hotwired/stimulus"

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
    e.currentTarget.value=""
  }
}
