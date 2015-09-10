healthApp = angular.module("healthApp", [
  'ngResource'
  'templates',
  'ngRoute',
  'controllers'
])

healthApp.factory("Patient", ($resource)->
  $resource("http://api.health-app.dev:3000/patients/:id", {id: "@id"},
  {
    'show': { method: 'GET', isArray: false}
  })
)

healthApp.config([ '$routeProvider', '$locationProvider', '$httpProvider'
  ($routeProvider, $locationProvider, $httpProvider)->
    $locationProvider.html5Mode(true).hashPrefix('!')
    $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token').attr('content')
    $httpProvider.defaults.headers['Access-Control-Allow-Origin'] = '*'
    $httpProvider.defaults.headers['Access-Control-Request-Method'] = '*'
    $routeProvider
      .when('/',
        templateUrl: 'index.html'
        controller: 'PatientIndexController'
      )
      .when('/patients/:id',
        templateUrl: "show.html"
        controller: 'PatientShowController'
      )
])

controllers = angular.module('controllers', [])
