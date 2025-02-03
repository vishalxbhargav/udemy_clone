import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["title", "description", "result"]

  connect() {
    console.log("connected by question controller")
  }

  submit(e) {
    
    e.preventDefault()
    const title = this.titleTarget.value.trim()
    const description = this.descriptionTarget.value.trim()

    if (!title || !description) {
      alert("Please provide both Title and Description")
      return
    }

    this.titleTarget.value = ""
    this.descriptionTarget.value = ""

    const forumId = (e.currentTarget).id.replace("forume_", "")
    console.log("Forum ID:", forumId)

    fetch(`/forume/forumes/${forumId}/questions`, {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": (document.querySelector("[name='csrf-token']")).content,
      },
      body: JSON.stringify({
        title: title,
        description: description,
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
