Dispatcher    = require('flux').Dispatcher
Assign        = require('object-assign')


AppDispatcher = Assign(new Dispatcher(),
  # Bridge between the views and dispatcher
  #
  # @param  {object} action The data coming from the view.
  #
  handleViewAction: (action) ->
    @dispatch
      source: "VIEW_ACTION"
      action: action

    return

  # Bridge between the server and dispatcher
  #
  # @param  {object} action The data coming from the server.
  #
  handleServerAction: (action) ->
    @dispatch
      source: "SERVER_ACTION"
      action: action

    return
  )

module.exports = AppDispatcher
