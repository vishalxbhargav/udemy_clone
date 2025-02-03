import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="answer"
export default class extends Controller {
  static targets=["body","result"]
  connect() {
    console.log("connected by answer")
  }
  submit(e){
    e.preventDefault()
    const body = this.bodyTarget.value.trim()

    if (!body) {
      alert("Please provide content for answer")
      return
    }

    this.bodyTarget.value = ""

    const question_id = (e.currentTarget).id.replace("question_", "")
    console.log("Forum ID:", question_id)
    
    fetch(`/forume/questions/${question_id}/answers`, {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": (document.querySelector("[name='csrf-token']")).content,
      },
      body: JSON.stringify({
        body: body
      }),
    })
      .then((response) => response.text())
      .then((result) => {
        this.resultTarget.innerHTML = result
      })
      .catch((error) => {
        console.error("Error:", error)
        alert("Something went wrong!")
      })
  }
}
