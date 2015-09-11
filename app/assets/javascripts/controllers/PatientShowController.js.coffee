controllers = angular.module('controllers')
controllers.controller('PatientShowController', [ '$scope', 'Patient', '$routeParams', '$resource', '$location', '$interval',
  ($scope, Patient, $routeParams,$resource, $location, $interval)->
    $scope.back = -> $location.path("/")
    $interval (->
      show_patient($scope, Patient, $routeParams.id)
      return
    ).bind(this), 5000
    show_patient($scope, Patient, $routeParams.id)
])

show_patient = ($scope, Patient, id)->
  $scope.patient = Patient.show({id: id})
  console.log 'Refresh'
