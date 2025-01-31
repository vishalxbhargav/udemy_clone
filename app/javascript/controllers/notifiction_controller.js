import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="notifiction"
export default class extends Controller {
  connect() {
    console.log("connected")
  }
  submit(){
    try {
      const data=fetch(`/notification/all_read`,{
        method: "post"
      })
      console.log(data.json())
    } catch (error) {
      
    }
  }
  
}
