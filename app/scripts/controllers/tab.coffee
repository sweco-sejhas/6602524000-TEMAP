'use strict'

angular.module('TEMAPApp')
  .controller 'TabCtrl', ($scope) ->    
    $scope.typeTab = 
      active:true
      disabled:false
      
    $scope.objTab =
      active:false
      disabled:true
      
    $scope.mapTab =
      active:false
      disabled:true
      updateSize:false
