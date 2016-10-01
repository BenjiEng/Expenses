this.Item = React.createClass ({

  getInitialState: function() {
    return {
      edit: false
    };
  },

  //handles toggle action for edit state
  handleToggle: function(e) {
    e.preventDefault();
    return this.setState({
      edit: !this.state.edit
    });
  },

  //handles edit action
  handleEdit: function(e) {
    var data;
    e.preventDefault();
    data = {
      title: ReactDOM.findDOMNode(this.refs.title).value,
      date: ReactDOM.findDOMNode(this.refs.date).value,
      amount: ReactDOM.findDOMNode(this.refs.amount).value
    };
    return $.ajax({
      method: 'PUT',
      url: "/items/" + this.props.item.id,
      dataType: 'JSON',
      data: {
        item: data
      },
      success: (function(_this) {
        return function(data) {
          _this.setState({
            edit: false
          });
          return _this.props.handleEditItem(_this.props.item, data);
        };
      })(this)
    });
  },

  itemRow: function() {
    return React.DOM.tr(null, React.DOM.td(null, this.props.item.date), React.DOM.td(null, this.props.item.title), React.DOM.td(null, amountFormat(this.props.item.amount)), React.DOM.td(null, React.DOM.a({
      className: 'btn btn-default',
      onClick: this.handleToggle
    }, 'Edit'), React.DOM.a({
      className: 'btn btn-danger',
      onClick: this.handleDelete
    }, 'Delete')));
  },

  itemForm: function() {
    return React.DOM.tr(null, React.DOM.td(null, React.DOM.input({
      className: 'form-control',
      type: 'text',
      defaultValue: this.props.item.date,
      ref: 'date'
    })), React.DOM.td(null, React.DOM.input({
      className: 'form-control',
      type: 'text',
      defaultValue: this.props.item.title,
      ref: 'title'
    })), React.DOM.td(null, React.DOM.input({
      className: 'form-control',
      type: 'number',
      defaultValue: this.props.item.amount,
      ref: 'amount'
    })), React.DOM.td(null, React.DOM.a({
      className: 'btn btn-default',
      onClick: this.handleEdit
    }, 'Update'), React.DOM.a({
      className: 'btn btn-danger',
      onClick: this.handleToggle
    }, 'Cancel')));
  },

  //handles delete action
  handleDelete: function(e) {
    e.preventDefault();
    return $.ajax({
      method: 'DELETE',
      url: "/items/" + this.props.item.id,
      dataType: 'JSON',
      success: (function(_this) {
        return function() {
          return _this.props.handleDeleteItem(_this.props.item);
        };
      })(this)
    });
  },

  render: function() {
    if (this.state.edit) {
      return this.itemForm();
    } else {
      return this.itemRow();
    }
  }
});
