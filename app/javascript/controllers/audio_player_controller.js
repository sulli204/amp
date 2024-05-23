import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["play", "pause"]
  static classes = ["hide"]


  play () {
    let audioPlayer = document.getElementById("audio-player")
    this.playTarget.classList.add(this.hideClass)
    this.pauseTarget.classList.remove(this.hideClass)
    audioPlayer.play()
  }

  pause () {
    let audioPlayer = document.getElementById("audio-player")
    this.playTarget.classList.remove(this.hideClass)
    this.pauseTarget.classList.add(this.hideClass)
    audioPlayer.pause()
  }
}
