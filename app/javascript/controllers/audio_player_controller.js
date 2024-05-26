import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["play", "pause"]
  static classes = ["hide"]

  play () {
    let audioPlayer = document.getElementById("audio-player")
    let current_song_id = audioPlayer.getAttribute("song")

    if (!current_song_id) {
      return
    }

    let currentSongPlayIcon = document.getElementById(current_song_id + "-play-icon")
    let currentSongPauseIcon = document.getElementById(current_song_id + "-pause-icon")

    currentSongPlayIcon.classList.add(this.hideClass)
    currentSongPauseIcon.classList.remove(this.hideClass)

    this.playTarget.classList.add(this.hideClass)
    this.pauseTarget.classList.remove(this.hideClass)
    audioPlayer.play()
  }

  pause () {
    let audioPlayer = document.getElementById("audio-player")
    let current_song_id = audioPlayer.getAttribute("song")

    let currentSongPlayIcon = document.getElementById(current_song_id + "-play-icon")
    let currentSongPauseIcon = document.getElementById(current_song_id + "-pause-icon")

    currentSongPlayIcon.classList.remove(this.hideClass)
    currentSongPauseIcon.classList.add(this.hideClass)

    this.playTarget.classList.remove(this.hideClass)
    this.pauseTarget.classList.add(this.hideClass)
    audioPlayer.pause()
  }
}
