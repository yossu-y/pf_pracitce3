import consumer from "./consumer"

consumer.subscriptions.create("RoomChannel", {
  connected() {
    console.log("connected")
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    const message = document.getElementById("message")
    messages.innnerHTML += "<p>${data}</p>"
    // Called when there's incoming data on the websocket for this channel
  },

  speak: function(content) {
    return this.perform('speak', {message: content});
  }
});

document.addEventListener("DOMContentLoaded", function(){
  const input = document.getElementById("chat-input")
  const button = document.getElementById("button")
  button.addEventListener("click", function(){
    const content = input.value
    App.room.speak(content)
    input.value = ""
  })
})
