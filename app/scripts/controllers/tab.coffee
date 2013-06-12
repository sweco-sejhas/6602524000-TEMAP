'use strict'

angular.module('TEMAPApp')
  .controller 'TabCtrl', ($scope) ->    
    $scope.typeTab = 
      active:true
      
    $scope.objTab =
      active:false
      
    $scope.mapTab =
      active:false
