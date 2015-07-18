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
  new Notification(data.event, {"body": JSON.stringify(data.user) });
});

chan.on("cardevent", data => {
  console.log(data);
  new Notification(data.event, {"body": JSON.stringify(data.card) });
});

var HelloWorld = React.createClass({
  render() {
    return (<h1>Hello World</h1>)
  }
})

window.onload = () => {
  var element = document.getElementById("content")
  React.render(<HelloWorld />, element)
}