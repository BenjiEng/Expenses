 @Items = React.createClass

    getInitialState: ->
      items: @props.data
    getDefaultProps: ->
      items: []
    addItem: (item) ->
      items = @state.items.slice()
      items.push item
      @setState items: items

    render: ->
      React.DOM.div
        className: 'items'
        React.DOM.h2
          className: 'title'
          'Items'
        React.createElement ItemForm, handleNewItem: @addItem
        React.DOM.hr null
        React.DOM.table
          className: 'table table-bordered'
          React.DOM.thead null,
            React.DOM.tr null,
              React.DOM.th null, 'Date'
              React.DOM.th null, 'Title'
              React.DOM.th null, 'Amount'
          React.DOM.tbody null,
            for item in @state.items
              React.createElement Item, key: item.id, item: item
