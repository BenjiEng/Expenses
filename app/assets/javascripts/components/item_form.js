this.ItemForm = React.createClass ({

  getInitialState: function() {
    return {
      title: 'Food',
      date: '',
      amount: ''
    };
  },

  valid: function() {
    return this.state.title && this.state.date && this.state.amount;
  },

  handleChange: function(e) {
    var name, obj;
    name = e.target.name;
    return this.setState((
      obj = {},
      obj["" + name] = e.target.value,
      obj
    ));
  },

  handleSubmit: function(e) {
    e.preventDefault();

    if (this.state.title === "Deposit") {
      this.state.amount *= -1;
    }

    return $.post('', {
      item: this.state
    }, (function(_this) {
      return function(data) {
        _this.props.handleNewItem(data);
        return _this.setState(_this.getInitialState());
      };
    })(this), 'JSON');
  },

  render: function() {
    return React.DOM.form ({
      className: 'form-inline',
      onSubmit: this.handleSubmit
    },
      React.DOM.div ({
        className: 'form-group'
      },
        React.DOM.input ({
        type: 'text',
        className: 'form-control',
        placeholder: 'Transaction Date',
        name: 'date',
        value: this.state.date,
        onChange: this.handleChange
     })),
     React.DOM.div({
      className: 'form-group'
     },
        React.DOM.select({
          multiple: false,
          name: 'title',
          value: this.state.title,
          defaultValue: 'Food',
          onChange: this.handleChange
        }, 'Select Type',
          React.DOM.option({
            value: 'Food',
            name: 'food',
          }, 'Food'),
          React.DOM.option({
            value: 'Medical',
            name: 'medical'
          }, 'Medical'),
          React.DOM.option({
            value: 'Transportation',
            name: 'Transportation'
          }, 'Transportation'),
          React.DOM.option({
            value: 'Withdrawal',
            name: 'withdrawal'
          }, 'Withdrawal'),
          React.DOM.option({
            value: 'Deposit',
            name: 'deposit'
          }, 'Deposit'),
          React.DOM.option({
            value: 'Other',
            name: 'other'
          }, 'Other')
      )
    ),
    React.DOM.div({
      className: 'form-group'
    },
        React.DOM.input({
        type: 'number',
        className: 'form-control',
        placeholder: 'Amount',
        name: 'amount',
        value: this.state.amount,
        onChange: this.handleChange
    })),
    React.DOM.button({
      type: 'submit',
      className: 'btn btn-primary',
      disabled: !this.valid()
    }, 'Create item'));
  }

});
