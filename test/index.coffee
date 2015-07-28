
Flux  = require('../src')

OrderActions =
  view  :
    addOrder: (data) ->
      OrderStore.setState(data)

Flux.createStore({
  name      : 'UserStore'
  data      : {
                id          : 1
                first_name  : 'sam'
                surname     : 'ternent'
                age         : 29
                sex         : 'male'
                hasOrder    : false
                orders      : []
              }

  })

Flux.createStore({
    name          : 'OrderStore'
    data          : { }
    actions       : OrderActions
  })




window.UserStore  = Flux.getStore('UserStore')
window.OrderStore = Flux.getStore('OrderStore')

OrderStore.addChangeListener ->
  orderState = OrderStore.getState()
  if orderState.userId is UserStore.getStateValue('id')
    orders = UserStore.getStateValue('orders')
    orders.push(orderState)

    UserStore.setState({
      hasOrder  : true
      orders    : orders
      })
    console.log UserStore.getState()
