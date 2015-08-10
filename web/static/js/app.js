import {Socket} from "deps/phoenix/web/static/js/phoenix"
import "deps/phoenix_html/web/static/js/phoenix_html"
import Cards from "./cards"

Notification.requestPermission();

window.onload = () => {
  var element = document.getElementById("content")
  React.render(<Cards />, element)
}