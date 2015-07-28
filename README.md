# tbg-flux-factory
Factory wrapper for [flux](https://github.com/facebook/flux)

### Install

`npm install tbg-flux-factory --save`

https://www.npmjs.com/package/tbg-flux-factory

### How it works

Working [example gist](http://requirebin.com/?gist=ecbd038f297594dab76a) 

#### Register a new store with actions
```
var FluxFactory = require('tbg-flux-factory');

var LoginStore = FluxFactory.createStore({
  name		: 'Login',
  data		: {
    logged_in			: false,
    login_open    : false
  },
	actions : {
	  view    : {
	    toggle_showLogin: function () {
	      LoginStore.setState({
	        login_open  : !LoginStore.getStateValue('login_open')
	      });
	    }
	  },
	  server	: {
    	login: function (params) {
        xhr('to_login_', params);
    	}
    }
	}
});
```

#### Register actions to a store

```
var Flux        = require('tbg-flux-factory');
var LoginStore  = Flux.getStore('Login');

LoginStore.registerActions({
  view    : {
    toggle_showLogin: function () {
      LoginStore.setState({
        login_open  : !LoginStore.getStateValue('login_open')
      });
    }
  },
  server	: {
  	login: function (params) {
      xhr('to_login_', params);
  	}
  }
});

```

#### Use with a synced state to components

```
var Flux        = require('tbg-flux-factory');
var LoginStore  = Flux.getStore('Login');

---

getInitialState : function () {
	return LoginStore.getState();
},

componentWillMount : function () {
  var that = this;
  LoginStore.addChangeListener(function () {
  	that.setState(LoginStore.getState());
  });
},

_handleLoginClick : function (e) {
  e.preventDefault();
  var params = __getParamsHere()
  LoginStore.Actions.login(params);
},
_handleShowLogin : function () {
  LoginStore.Actions.toggle_showLogin();
},

---
```

#### Listen to other stores
```
var Flux        = require('tbg-flux-factory');
var LoginStore  = Flux.getStore('Login');
var UserStore  	= Flux.getStore('User');

LoginStore.addChangeListener(function () {
	UserStore.Actions.fetchUserDetails()
});
```
