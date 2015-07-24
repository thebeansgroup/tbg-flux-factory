# Create a flux factory here
Flux  = require('./flux_factory')

window.UserStore = new Flux.Store({
  name      : ''
  age       : null
  sex       : ''
  hasOrder  : false
  })

window.OrderStore = new Flux.Store({
  order     : ''
  })

UserStore.addChangeListener ->
  Store.getState()
