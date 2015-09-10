controllers = angular.module('controllers')
controllers.controller('PatientShowController', [ '$scope', 'Patient', '$routeParams', '$resource', '$location',
  ($scope, Patient, $routeParams,$resource, $location)->
     $scope.patient = Patient.show({id: $routeParams.id})
     $scope.back = -> $location.path("/")
])