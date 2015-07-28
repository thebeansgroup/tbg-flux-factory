Dispatcher   = require('../dispatcher/')
Store        = require('../store/')

Assign       = require('object-assign')


_stores = {}

class FluxFactory


  getStore    : (name) ->
    return _stores[ name ]

  createStore : (params) ->
    _stores[ params.name ] = Assign( {}, Store, params )
    _stores[ params.name ].dispatcherIndex = Dispatcher.register( (payload) ->
      action = payload.action

      actionType  = action.actionType.split('.')
      _nsp        = actionType.shift(0)
      actionType  = actionType.join('.')

      return true if _nsp isnt _stores[ params.name ].name
      _stores[ params.name ][ actionType ]?(action.data)
      return true
    )
    _stores[ params.name ]._init(params.init)
    return _stores[ params.name ]


module.exports = new FluxFactory()
