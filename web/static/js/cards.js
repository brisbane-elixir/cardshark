module.exports = React.createClass({
  getInitialState: function() {
    return {
      cards: null
    };
  },

  componentWillMount: function() {
    var component = this;
    var socket = new Phoenix.Socket("/ws");
    var chan = socket.chan("stream", {});
    socket.connect();
    chan.join().receive("ok", (cards) => {
      console.log(cards);
      this.setState({cards: cards});
    })
    chan.on("cardevent", data => {
      console.log(data);
      new Notification(data.event, {"body": JSON.stringify(data.card) });
    });
  },

  render: function() {
    if (this.state.cards) {
      return(<p>Loaded</p>)
    } else {
      return (<p>Loading ... please wait</p>)
    }
  }
})