import React from "react"
import {Socket} from "../../../deps/phoenix/web/static/js/phoenix"
import Project from "./project"
import _ from "lodash"

module.exports = React.createClass({
  getInitialState: function() {
    return {
      projects: null
    };
  },

  componentWillMount: function() {
    var component = this;
    var socket = new Socket("/ws");
    var chan = socket.channel("stream");
    socket.connect({});
    chan.join().receive("ok", (data) => {
      console.log(data);
      this.setState({projects: data.projects});
    })
    chan.on("cardevent", data => {
      var cards = this.state.cards;
      cards.push(data.card);
      this.setState({cards: cards});
    });
  },

  render: function() {
    var transform = function(project) {
      return (<Project project={project} />);
    }
    if (this.state.projects) {
      return(<div>{ _.map(this.state.projects, transform) }</div>)
    } else {
      return (<p>Loading ... please wait</p>)
    }
  }
});
