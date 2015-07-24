EventEmitter      = require('events').EventEmitter
assign            = require('object-assign')


CHANGE_EVENT      = 'change'

class Store extends EventEmitter

  data = null

  constructor: (initialState) ->
    @data = initialState


  setState: (obj) ->
    @data = assign({}, @data, obj)
    @emitChange()

  setStateValue: (key, value) ->
    @data[ key ] = value
    @emitChange()

  getState: -> @data

  getStateValue: (key) -> @data[ key ]


  emitChange: ->
    @emit(CHANGE_EVENT)

  addChangeListener: (callback) ->
    @on(CHANGE_EVENT, callback)

  removeChangeListener: (callback) ->
    @removeListener(CHANGE_EVENT, callback)




module.exports = Store
