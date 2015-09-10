controllers = angular.module('controllers')
controllers.controller('PatientIndexController', [ '$scope', '$routeParams', '$resource', '$location',
  ($scope,$routeParams,$resource, $location)->
     Patients = $resource('/patients.json')
     $scope.patients = Patients.query()
])