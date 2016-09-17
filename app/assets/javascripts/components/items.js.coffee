 @Items = React.createClass

    getInitialState: ->
      items: @props.data

    getDefaultProps: ->
      items: []

    addItem: (item) ->
      items = @state.items.slice()
      items.push item
      @setState items: items

    credits: ->
      credits = @state.items.filter (val) -> val.amount >= 0
      credits.reduce ((prev, current) ->
        prev + parseFloat(current.amount)
      ), 0

    debits: ->
      debits = @state.items.filter (val) -> val.amount < 0
      debits.reduce ((prev, current) ->
        prev + parseFloat(current.amount)
      ), 0

    balance: ->
      @debits() + @credits()

    render: ->
      React.DOM.div
        className: 'items'
        React.DOM.h2
          className: 'title'
          'Items'
        React.DOM.div
          className: 'row'
          React.createElement AmountBox, type: 'success', amount: @credits(), text: 'Credit'
          React.createElement AmountBox, type: 'danger', amount: @debits(), text: 'Debit'
          React.createElement AmountBox, type: 'info', amount: @balance(), text: 'Balance'
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
