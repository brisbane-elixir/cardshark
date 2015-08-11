import React from "react"

module.exports = React.createClass({
  render: function() {
    return(<div className="project">
			<p>{ this.props.project.name }</p>
    </div>);
  }
});
