import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="mark-as-complete"
export default class extends Controller {
  static targets=["load"]
  connect() {
    console.log("conneted")
  }
  submit(e){
    const clickedElement = e.currentTarget;
    const chapterId = clickedElement.id.replace("chapter_", "");
    console.log(chapterId)
    fetch(`/instructor/mark_as_complete/${chapterId}`,{method: "post"})
    .then((response) => response.text())
      .then((html) => {
        this.loadTarget.innerHTML = html;
        
    });
    setTimeout(()=>{
      this.loadTarget.style.displey="none"
      console.log("status bar hide")
    },2000)
  }
}
