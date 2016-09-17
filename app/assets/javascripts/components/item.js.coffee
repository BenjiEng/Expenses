@Item = React.createClass
  render: ->
    React.DOM.tr null,
      React.DOM.td null, @props.item.date
      React.DOM.td null, @props.item.title
      React.DOM.td null, amountFormat(@props.item.amount)
