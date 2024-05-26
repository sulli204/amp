import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = {
    id: String,         // Selected song uuid
    path: String,       // Song path to r2 bucket
    playbackUrl: String // r2 publically accessed url
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

    let audioPlayerPlay = document.getElementById("audio-player-play")
    let audioPlayerPause = document.getElementById("audio-player-pause")

    audioPlayerPlay.classList.add(this.hideClass)
    audioPlayerPause.classList.remove(this.hideClass)

    this.playTarget.classList.add(this.hideClass)
    this.pauseTarget.classList.remove(this.hideClass)

    audioPlayer.setAttribute("song", this.idValue)
    audioPlayer.setAttribute("src", this.playbackUrlValue + this.pathValue)

    audioPlayer.play()
  }

  unpause() {
    let audioPlayer = document.getElementById("audio-player")

    let audioPlayerPlay = document.getElementById("audio-player-play")
    let audioPlayerPause = document.getElementById("audio-player-pause")

    audioPlayerPlay.classList.add(this.hideClass)
    audioPlayerPause.classList.remove(this.hideClass)

    this.playTarget.classList.add(this.hideClass)
    this.pauseTarget.classList.remove(this.hideClass)

    audioPlayer.play()
  }

  pause() {
    let audioPlayer = document.getElementById("audio-player")

    let audioPlayerPlay = document.getElementById("audio-player-play")
    let audioPlayerPause = document.getElementById("audio-player-pause")

    audioPlayerPlay.classList.remove(this.hideClass)
    audioPlayerPause.classList.add(this.hideClass)

    this.playTarget.classList.remove(this.hideClass)
    this.pauseTarget.classList.add(this.hideClass)

    audioPlayer.pause()
  }

  swtich_songs(current_song_id) {
    let audioPlayer = document.getElementById("audio-player")

    let currentSongPlayIcon = document.getElementById(current_song_id + "-play-icon")
    let currentSongPauseIcon = document.getElementById(current_song_id + "-pause-icon")

    currentSongPlayIcon.classList.remove(this.hideClass)
    currentSongPauseIcon.classList.add(this.hideClass)
    this.start()
  }
}
