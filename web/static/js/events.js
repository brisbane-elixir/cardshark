import {EventEmitter} from "events"
import {Socket} from "../../../deps/phoenix/web/static/js/phoenix"

var emitter = new EventEmitter();

var socket = new Socket("/ws");
var chan = socket.channel("stream");
socket.connect({});

chan.join().receive("ok", (data) => {
  emitter.emit('projects', data.projects);
})

chan.on("projectevent", data => {
  emitter.emit('projectevent', data.project);
});

module.exports = emitter;
