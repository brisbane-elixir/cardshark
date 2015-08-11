import React from "react"
import events from "./events"
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
    events.on("projects", (projects) => {
      this.setState({projects: projects});
    })
    events.on("projectevent", project => {
      var projects = this.state.projects;
      projects.push(project);
      this.setState({projects: projects});
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
