module.exports = React.createClass({
  render: function() {
    return(<div className="card">
			<p>{ this.props.card.summary }</p>
    </div>);
  }
});
