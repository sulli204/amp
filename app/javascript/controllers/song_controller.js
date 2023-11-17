import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = {
    id: String,
    path: String
  }


  async play() {
    let audioPlayer = document.getElementById("audio-player")
    let current_song = audioPlayer.getAttribute("song")

    if (current_song === this.pathValue) {
      return
    } else {
      audioPlayer.setAttribute("song", this.pathValue)
      audioPlayer.setAttribute("src", "https://pub-527d9c7ea2cd4de4ba5105088eb10f97.r2.dev/" + this.pathValue)
    }
  }
}
