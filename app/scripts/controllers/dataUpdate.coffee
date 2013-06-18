'use strict'

angular.module('TEMAPApp')
  .controller 'DataUpdateCtrl', ($scope, data, db) ->
    $scope.updating = true
    
    $scope.data = data
    
    $scope.$on 'data::dataUpdated', (ev)->  
      $scope.$apply ->
        #$scope.updating = false
    
    data.update()
