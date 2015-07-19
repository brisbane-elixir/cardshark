import Card from "./card"

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
      this.setState({cards: cards});
    })
    chan.on("cardevent", data => {
      var cards = this.state.cards;
      new Notification(data.event, {"body": JSON.stringify(data.card) });
    });
  },

  render: function() {
    var transform = function(card) {
      return (<Card card={card} />);
    }
    if (this.state.cards) {
      return(<div>{ _.map(this.state.cards, transform) }</div>)
    } else {
      return (<p>Loading ... please wait</p>)
    }
  }
});
