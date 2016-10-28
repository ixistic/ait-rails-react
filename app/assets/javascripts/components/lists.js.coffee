@Lists = React.createClass
  getInitialState: ->
    lists: @props.data
  getDefaultProps: ->
    lists: []
  addList: (list) ->
    lists = @state.lists.slice()
    lists.push list
    @setState lists: lists
  deleteList: (list) ->
    lists = @state.lists.slice()
    index = lists.indexOf list
    lists.splice index, 1
    @replaceState lists: lists
  updateList: (list, data) ->
    index = @state.lists.indexOf list
    lists = @state.lists.slice()
    lists.splice index, 1, data
    @replaceState lists: lists
  render: ->
    React.DOM.div
      className: 'lists'
      React.DOM.h2
        className: 'title'
        'Shopping List'
      React.createElement ListForm, handleNewList: @addList
      React.DOM.hr null
      React.DOM.table
        className: 'table table-bordered'
        React.DOM.thead null,
          React.DOM.tr null,
            React.DOM.th null, 'Title'
            React.DOM.th null, 'Description'
            React.DOM.th null, 'Amount'
            React.DOM.th null, ''
        React.DOM.tbody null,
          for list in @state.lists
            React.createElement List, key: list.id, list: list, handleDeleteList: @deleteList, handleEditList: @updateList
