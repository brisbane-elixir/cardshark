import {Socket} from "phoenix"

let socket = new Socket("/ws")
socket.connect()
socket.join("stream", {}).receive("ok", chan => {
  console.log('joined', chan)

  chan.on("userevent", data => {
    console.log(data)
  });
})

let App = {
}

export default App
