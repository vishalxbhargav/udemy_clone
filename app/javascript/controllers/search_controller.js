import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="search"
export default class extends Controller {
  static targets = [ "query" ,"load"]
  connect() {
    console.log("connected to stimulus")
    this.queryTarget.addEventListener('change',(e)=>{
      e.target.value
    })
    console.log(this.loadTarget)
  }
  getData(){
    
  }

  submit(e){
    e.preventDefault()
    console.log(this.queryTarget.value)
    fetch(`/search?query=${this.queryTarget.value}`).then((response) => response.text())
    .then((html) => {
      console.log(html)
      this.loadTarget.innerHTML = html;
    })
  }
}
