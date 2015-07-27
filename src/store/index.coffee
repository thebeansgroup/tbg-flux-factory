Dispatcher        = require('../dispatcher/')
EventEmitter      = require('events').EventEmitter
assign            = require('object-assign')

CHANGE_EVENT      = 'change'


Store  = assign({}, EventEmitter::,
  name        : ''
  data        : {}

  # This is the public Actions collection
  Actions     : {}

  _selfInit: (init) ->
    init?()
    @registerViewAction('setState')

  setState: (obj) ->
    @data = assign({}, @data, obj)
    @emitChange()


  # get state
  getState: -> @data
  getStateValue: (key) -> @data[ key ]


  # Register view action
  registerViewAction: (name, func) ->
    action = {}
    @[ name ] = func if func?

    action[ name ] = (data) =>
      Dispatcher.handleViewAction
        actionType  : "#{@name}.#{name}"
        data        : data

    @Actions = assign( {}, @Actions, action )

  # Register server action
  registerServerAction: (name, func) ->
    action = {}
    @[ name ] = func
    action[ name ] = (data) =>
      Dispatcher.handleServerAction
        actionType  : "#{@name}.#{name}"
        data        : data

    @Actions = assign( {}, @Actions, action )



  # Change event and listeners
  emitChange: ->
    @emit(CHANGE_EVENT)

  addChangeListener: (callback) ->
    @on(CHANGE_EVENT, callback)

  removeChangeListener: (callback) ->
    @removeListener(CHANGE_EVENT, callback)

)

module.exports = Store
