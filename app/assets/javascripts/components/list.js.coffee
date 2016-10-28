@List = React.createClass
  getInitialState: ->
    edit: false
  handleToggle: (e) ->
    e.preventDefault()
    @setState edit: !@state.edit
  handleDelete: (e) ->
    e.preventDefault()
    $.ajax
      method: 'DELETE'
      url: "/lists/#{ @props.list.id }"
      dataType: 'JSON'
      success: () =>
        @props.handleDeleteList @props.list
  handleEdit: (e) ->
    e.preventDefault()
    data =
      title: ReactDOM.findDOMNode(@refs.title).value
      description: ReactDOM.findDOMNode(@refs.description).value
      amount: ReactDOM.findDOMNode(@refs.amount).value
    $.ajax
      method: 'PUT'
      url: "/lists/#{ @props.list.id }"
      dataType: 'JSON'
      data:
        list: data
      success: (data) =>
        @setState edit: false
        @props.handleEditList @props.list, data
  listRow: ->
    React.DOM.tr null,
      React.DOM.td null, @props.list.title
      React.DOM.td null, @props.list.description
      React.DOM.td null, @props.list.amount
      React.DOM.td null,
        React.DOM.a
          className: 'btn btn-default'
          onClick: @handleToggle
          'Edit'
        React.DOM.a
          className: 'btn btn-default'
          onClick: @handleDelete
          'Delete'
  listForm: ->
    React.DOM.tr null,
      React.DOM.td null,
        React.DOM.input
          className: 'form-control'
          type: 'text'
          defaultValue: @props.list.title
          ref: 'title'
      React.DOM.td null,
        React.DOM.input
          className: 'form-control'
          type: 'text'
          defaultValue: @props.list.description
          ref: 'description'
      React.DOM.td null,
        React.DOM.input
          className: 'form-control'
          type: 'number'
          defaultValue: @props.list.amount
          ref: 'amount'
      React.DOM.td null,
        React.DOM.a
          className:'btn btn-default'
          onClick: @handleEdit
          'Update'
        React.DOM.a
          className: 'btn btn-default'
          onClick: @handleToggle
          'Cancel'
  render: ->
    if @state.edit
      @listForm()
    else
      @listRow()
