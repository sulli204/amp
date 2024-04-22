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
    let current_song_id = audioPlayer.getAttribute("song")

    let selected_song_id = this.idValue

    if (current_song_id) {
      if (current_song_id == selected_song_id) {
        if (audioPlayer.paused) {
          this.unpause(selected_song_id)
        } else {
          this.pause()
        }
      } else {
        this.swtich_songs(current_song_id)
      }

    } else {
      this.start(selected_song_id)
    }
  }

  start() {
    let audioPlayer = document.getElementById("audio-player")
    console.log("Starting song " + this.idValue)

    this.playTarget.classList.add(this.hideClass)
    this.pauseTarget.classList.remove(this.hideClass)

    audioPlayer.setAttribute("song", this.idValue)
    audioPlayer.setAttribute("src", this.playbackUrlValue + this.pathValue)

    audioPlayer.play()
  }

  unpause() {
    let audioPlayer = document.getElementById("audio-player")

    this.playTarget.classList.add(this.hideClass)
    this.pauseTarget.classList.remove(this.hideClass)

    audioPlayer.play()
  }

  pause() {
    let audioPlayer = document.getElementById("audio-player")

    this.playTarget.classList.remove(this.hideClass)
    this.pauseTarget.classList.add(this.hideClass)

    audioPlayer.pause()
  }

  swtich_songs(current_song_id) {
    let audioPlayer = document.getElementById("audio-player")

    let current_song_play_icon = document.getElementById(current_song_id + "-play-icon")
    let current_song_pause_icon = document.getElementById(current_song_id + "-pause-icon")

    current_song_play_icon.classList.remove(this.hideClass)
    current_song_pause_icon.classList.add(this.hideClass)

    this.start()
  }
}
