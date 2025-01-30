import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="payment"
export default class extends Controller {
  static targets=["btn"]
  connect() {
    console.log("connected")
  }
  submit(e){
    try {
      const clickedElement = e.currentTarget;
      const courseId = clickedElement.id.replace("course_", "");
    
      const data=fetch(`/payment/checkout/create/${courseId}`,{method: "POST"}).then((response) => response.text())
      .then((url) => {
        window.location = url
      });
      console.log(data)
    } catch (error) {
      
    }
    
    console.log("submited")
  }
}
