import {Socket} from "deps/phoenix/web/static/js/phoenix"
import Card from "./card"

module.exports = React.createClass({
  getInitialState: function() {
    return {
      cards: null
    };
  },

  componentWillMount: function() {
    var component = this;
    var socket = new Socket("/ws");
    var chan = socket.channel("stream");
    socket.connect({});
    chan.join().receive("ok", (cards) => {
      console.log('cards', cards);
      //this.setState({cards: cards});
    })
    chan.on("cardevent", data => {
      var cards = this.state.cards;
      cards.push(data.card);
      this.setState({cards: cards});
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
