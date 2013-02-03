# Setup
Prototypable.Router.reopen
  location: 'history'
  rootURL: '/'

# Router maps
Prototypable.Router.map (match) ->
  @resource 'users', ->
    @route 'new'
    @route 'edit',
      path: '/:user_id/edit'
    @route 'show'
      path: '/:user_id'

# Index route
Prototypable.IndexRoute = Ember.Route.extend
  setupController: (controller, model) ->
    @controllerFor('application').set('currentRoute', 'home')

# User routes
Prototypable.UsersRoute = Ember.Route.extend
  setupController: ->
    @controllerFor('application').set('currentRoute', 'users')

Prototypable.UsersIndexRoute = Prototypable.UsersRoute.extend
  model: ->
    Prototypable.User.find()
  setupController: (controller, model) ->
    @_super()
    controller.set('users', model)

Prototypable.UserRoute = Ember.Route.extend
  model: (params) ->
    Prototypable.User.find(params.user_id)
  setupController: (controller, model) ->
    controller.set('content', model)
    @controllerFor('application').set('currentRoute', 'users')

Prototypable.UsersShowRoute = Prototypable.UserRoute.extend()
Prototypable.UsersEditRoute = Prototypable.UserRoute.extend()

Prototypable.UsersNewRoute = Prototypable.UsersRoute.extend
  model: ->
    Prototypable.User.createRecord()
  setupController: (controller, model) ->
    @_super()
    controller.set('content', model)

