Dispatcher        = require('../dispatcher/')
EventEmitter      = require('events').EventEmitter
assign            = require('object-assign')

CHANGE_EVENT      = 'change'


Store  = assign({}, EventEmitter::,
  name        : ''
  data        : {}

  # This is the public Actions collection
  Actions     : {}

  _init: (init) ->
    @registerViewActions    assign {}, @viewActions, { setState: null }
    @registerServerActions  @serverActions
    @registerActions        @actions
    init?()

  setState: (obj) ->
    @data = assign {}, @data, obj
    @emitChange()


  # get state
  getState: -> @data
  getStateValue: (key) -> @data[ key ]


  registerActions: (actions) ->
    @registerViewActions    actions.view    if actions?
    @registerServerActions  actions.server  if actions?
    return @


  registerViewActions: (actions) ->
    @_registerAction 'handleViewAction', k, v     for k, v of actions
    return @

  registerServerActions: (actions) ->
    @_registerAction 'handleServerAction', k, v   for k, v of actions
    return @




  _registerAction: (handleType, name, func) ->
    action = {}
    @[ name ] = func if func?
    action[ name ] = (data) =>
      Dispatcher[ handleType ]
        actionType  : "#{@name}.#{name}"
        data        : data

    @Actions = assign {}, @Actions, action



  # Change event and listeners
  emitChange: ->
    @emit(CHANGE_EVENT)

  addChangeListener: (callback) ->
    @on(CHANGE_EVENT, callback)

  removeChangeListener: (callback) ->
    @removeListener(CHANGE_EVENT, callback)

)

module.exports = Store
