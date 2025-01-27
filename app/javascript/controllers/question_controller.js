import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="question"
export default class extends Controller {
  static targets = [ "title", "description","result" ]
  connect() {
    console.log("connected")
  }
  submit(e){
   
    fetch(window.location.href+"/question", {
      header:"application/json",
      method: "post",
      body:{
        title:this.titleTarget.value,
        description: this.descriptionTarget
      }
    }).then((response) => response.text())
    .then((html) => {
      console.log(html)
      this.loadTarget.innerHTML = html;
    })
  }
}
