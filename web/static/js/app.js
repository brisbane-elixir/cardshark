import {Socket} from "phoenix"

Notification.requestPermission();

let socket = new Phoenix.Socket("/ws");
let chan = socket.chan("stream", {});

socket.connect();

chan.join().receive("ok", ({messages}) => {
  console.log(messages);
})

chan.on("userevent", data => {
  console.log(data);
  // new Notification(data.event, {"body": JSON.stringify(data.user) });
});

chan.on("cardevent", data => {
  console.log(data);
  // new Notification(data.event, {"body": JSON.stringify(data.user) });
});
