@Items = React.createClass
  getInitialState: ->
    items: @props.data

  getDefaultProps: ->
    items: []

  credit: ->
    credit = @state.items.filter (val) -> val.amount >= 0
    credit.reduce ((prev, curr) ->
      prev + parseFloat(curr.amount)
    ), 0

  debit: ->
    debit = @state.items.filter (val) -> val.amount < 0
    debit.reduce ((prev, curr) ->
      prev + parseFloat(curr.amount)
    ), 0

  balance: ->
    @debit() + @credit()

  addItem: (item) ->
    items = React.addons.update(@state.items, { $push: [item] })
    @setState items: items

  deleteItem: (item) ->
    index = @state.items.indexOf item
    items = React.addons.update(@state.items, { $splice: [[index, 1]] })
    @replaceState items: items

  updateItem: (item, data) ->
    index = @state.items.indexOf item
    items = React.addons.update(@state.items, { $splice: [[index, 1, data]] })
    @replaceState items: items

  render: ->
    React.DOM.div
      className: 'items'
      React.DOM.h2
        className: 'title'
        'Items'
      React.DOM.div
        className: 'row'
        React.createElement AmountBox, type: 'success', amount: @credit(), text: 'Credit'
        React.createElement AmountBox, type: 'danger', amount: @debit(), text: 'Debit'
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
            React.DOM.th null, ''
        React.DOM.tbody null,
          for item in @state.items
            React.createElement Item, key: item.id, item: item, handleDeleteItem: @deleteItem, handleEditItem: @updateItem
