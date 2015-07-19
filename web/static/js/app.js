import Cards from "./cards"

Notification.requestPermission();

window.onload = () => {
  var element = document.getElementById("content")
  React.render(<Cards />, element)
}