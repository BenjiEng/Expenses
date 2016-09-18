@Item = React.createClass
  getInitialState: ->
    edit: false

  handleToggle: (e) ->
    e.preventDefault()
    @setState edit: !@state.edit

  handleDelete: (e) ->
    e.preventDefault()
    $.ajax
      method: 'DELETE'
      url: "/items/#{ @props.item.id }"
      dataType: 'JSON'
      success: () =>
        @props.handleDeleteItem @props.item

  handleEdit: (e) ->
    e.preventDefault()
    data =
      title: ReactDOM.findDOMNode(@refs.title).value
      date: ReactDOM.findDOMNode(@refs.date).value
      amount: ReactDOM.findDOMNode(@refs.amount).value
    $.ajax
      method: 'PUT'
      url: "/items/#{ @props.item.id }"
      dataType: 'JSON'
      data:
        item: data
      success: (data) =>
        @setState edit: false
        @props.handleEditItem @props.item, data

  itemRow: ->
    React.DOM.tr null,
      React.DOM.td null, @props.item.date
      React.DOM.td null, @props.item.title
      React.DOM.td null, amountFormat(@props.item.amount)
      React.DOM.td null,
        React.DOM.a
          className: 'btn btn-default'
          onClick: @handleToggle
          'Edit'
        React.DOM.a
          className: 'btn btn-danger'
          onClick: @handleDelete
          'Delete'

  itemForm: ->
    React.DOM.tr null,
      React.DOM.td null,
        React.DOM.input
          className: 'form-control'
          type: 'text'
          defaultValue: @props.item.date
          ref: 'date'
      React.DOM.td null,
        React.DOM.input
          className: 'form-control'
          type: 'text'
          defaultValue: @props.item.title
          ref: 'title'
      React.DOM.td null,
        React.DOM.input
          className: 'form-control'
          type: 'number'
          defaultValue: @props.item.amount
          ref: 'amount'
      React.DOM.td null,
        React.DOM.a
          className: 'btn btn-default'
          onClick: @handleEdit
          'Update'
        React.DOM.a
          className: 'btn btn-danger'
          onClick: @handleToggle
          'Cancel'

  render: ->
    if @state.edit
      @itemForm()
    else
      @itemRow()
