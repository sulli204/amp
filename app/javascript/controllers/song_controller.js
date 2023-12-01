import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = {
    id: String,
    path: String,
    playbackUrl: String
  }

  static targets = ["play", "pause"]
  static classes = ["hide"]

  load() {
    let audioPlayer = document.getElementById("audio-player")
    let current_song = audioPlayer.getAttribute("song")

    if (current_song === this.pathValue) {
      audioPlayer.paused ? this.play(audioPlayer) : this.pause(audioPlayer)
    } else {
      audioPlayer.setAttribute("song", this.pathValue)
      audioPlayer.setAttribute("src", this.playbackUrlValue + this.pathValue)
      this.play(audioPlayer)
    }
  }

  play(audioPlayer) {
    this.playTarget.classList.add(this.hideClass)
    this.pauseTarget.classList.remove(this.hideClass)
    audioPlayer.play()
  }

  pause(audioPlayer) {
    this.pauseTarget.classList.add(this.hideClass)
    this.playTarget.classList.remove(this.hideClass)
    audioPlayer.pause()
  }
}
