import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="comment"
export default class extends Controller {
  connect() {
    console.log("connected")
  }
  showComments(){
    console.log("show comments")
  }
  writeComment(){
    console.log("write comments")
  }

}
