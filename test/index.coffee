# this is an example test file ---- will remove


Flux  = require('./flux_factory')

Assign =  require('object-assign')




window.UserStore = Flux.createStore({
  name      : 'user'
  data      : {
                id          : 1
                first_name  : 'sam'
                surname     : 'ternent'
                age         : 29
                sex         : 'male'
                hasOrder    : false
                orders      : []
              }
  init       : ->
  })






window.OrderStore = Flux.createStore({
  name      : 'order'
  data      : {
                order     : {}
              }
  })

OrderStore.registerViewAction('addOrder', (data) ->
      orders = UserStore.getStateValue('orders').length
      OrderStore.setState(Assign({}, id: orders, data))
    )





UserStore.registerServerAction('postLogin', (data) ->
      params =
        user:
          email: data.email
          password: data.password

      success = (data) ->
        if data.success
          OrderStore.setState({ X_CSRF_TOKEN : data.token })
        else
          OrderStore.setState({ errors  : data.errors })

      console.log 'post', params
    )






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
