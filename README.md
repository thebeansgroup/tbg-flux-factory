# flux_factory

### Register a new store
```
Flux      = require('flux_factory')

UserStore = Flux.createStore({
  name      : 'user'
  data      : {
                logged_in     : false
                user_details  : null
              }
  })
```

### Register actions to a store
```
_postLogin = (params) ->
  params =
        user:
          email: data.email
          password: data.password

      success = (data) ->
          UserStore.setState({
            logged_in   : true
            user_details: data
          })
  
  _postAsync 'login_url', params, success
  

UserStore.registerServerAction('login', _postLogin)
```

### Listen to changes
```
componentWillMount: ->
  UserStore.addChangeListener ->
    @setState UserStore.getState()
```
