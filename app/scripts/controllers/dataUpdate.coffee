'use strict'

angular.module('TEMAPApp')
  .controller 'DataUpdateCtrl', ($scope, data, db, loadMessage) ->
    $scope.updating = true
    
    $scope.data = data
    
    $scope.loadMessage = loadMessage
    
    $scope.$on 'data::dataUpdated', ()->  
      $scope.$apply ->
        $scope.updating = false
    
    data.update()
