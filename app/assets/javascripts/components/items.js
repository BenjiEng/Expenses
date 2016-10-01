this.Items = React.createClass ({

  getInitialState: function() {
    return {
      items: this.props.data
    };
  },

  getDefaultProps: function() {
    return {
      items: []
    };
  },

  credit: function() {
    var credit = this.state.items.filter(function(val) {
      return val.amount >= 0;
    });
    return credit.reduce((function(prev, curr) {
      return prev + parseFloat(curr.amount);
    }), 0);
  },

  debit: function() {
    var debit = this.state.items.filter(function(val) {
      return val.amount < 0;
    });
    return debit.reduce((function(prev, curr) {
      return prev + parseFloat(curr.amount);
    }), 0);
  },

  balance: function() {
    return this.debit() + this.credit();
  },

  addItem: function(item) {
    var items;
    items = React.addons.update(this.state.items, {
      $push: [item]
    });
    return this.setState({
      items: items
    });
  },

  deleteItem: function(item) {
    var index, items;
    index = this.state.items.indexOf(item);
    items = React.addons.update(this.state.items, {
      $splice: [[index, 1]]
    });
    return this.replaceState({
      items: items
    });
  },

  updateItem: function(item, data) {
    var index, items;
    index = this.state.items.indexOf(item);
    items = React.addons.update(this.state.items, {
      $splice: [[index, 1, data]]
    });
    return this.replaceState({
      items: items
    });
  },

  render: function() {
    var item;
    return React.DOM.div({
      className: 'items'
    }, React.DOM.h2({
      className: 'title'
    }, 'Items'), React.DOM.div({
      className: 'row'
    }, React.createElement(AmountBox, {
      type: 'success',
      amount: this.credit(),
      text: 'Credit'
    }), React.createElement(AmountBox, {
      type: 'danger',
      amount: this.debit(),
      text: 'Debit'
    }), React.createElement(AmountBox, {
      type: 'info',
      amount: this.balance(),
      text: 'Balance'
    })), React.createElement(ItemForm, {
      handleNewItem: this.addItem
    }), React.DOM.hr(null), React.DOM.h4({
      className: 'expenses-header'
    }, 'Your Itemized Expenses'), React.DOM.table({
      className: 'table table-bordered'
    }, React.DOM.thead(null, React.DOM.tr(null, React.DOM.th(null, 'Transaction Date'), React.DOM.th(null, 'Expense Type'), React.DOM.th(null, 'Amount'), React.DOM.th(null, ''))), React.DOM.tbody(null, (function() {
      var i, len, ref, results;
      ref = this.state.items;
      results = [];
      for (i = 0, len = ref.length; i < len; i++) {
        item = ref[i];
        results.push(React.createElement(Item, {
          key: item.id,
          item: item,
          handleDeleteItem: this.deleteItem,
          handleEditItem: this.updateItem
        }));
      }
      return results;
    }).call(this))));
  }
});
