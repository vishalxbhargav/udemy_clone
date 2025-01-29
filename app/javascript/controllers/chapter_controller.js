import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="chapter"
export default class extends Controller {
  static targets=["load","welcome"]
  
  connect() {

  }
  action(e){
    this.welcomeTarget.style.display="none"
    this.welcomeTarget.style.height="0"
    this.welcomeTarget.style.width="0"
    const clickedElement = e.currentTarget;
    this.loadTarget.style.display="block"
    const chapterId = clickedElement.id.replace("chapter_", "");
    fetch(`/instructor/get_chapter/${chapterId}`)
      .then((response) => response.text())
      .then((html) => {
        this.loadTarget.innerHTML = html;
    });
  }
}
