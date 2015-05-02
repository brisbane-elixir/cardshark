import {Socket} from "phoenix"

Notification.requestPermission()

let socket = new Socket("/ws")
socket.connect()
socket.join("stream", {}).receive("ok", chan => {
  chan.on("userevent", data => {
    new Notification(data.event, {"body": JSON.stringify(data.user) })
  });
})

let App = {
}

export default App
