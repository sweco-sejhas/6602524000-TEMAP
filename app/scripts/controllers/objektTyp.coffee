'use strict'

angular.module('TEMAPApp')
  .controller 'ObjektTypCtrl', ($scope, ObjectType) ->
    $scope.objectTypes = [
      id:0
      name:'Belysningsstolpe'
     ,
      id:1
      name:'Kabelskåp'
     ,
      id:2
      name:'Nätstation']
      
    $scope.setType = (type) ->
      $scope.objTab.active = true
      ObjectType.selected = ''+type.id
