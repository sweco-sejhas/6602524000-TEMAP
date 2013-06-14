'use strict'

angular.module('TEMAPApp')
  .controller 'ObjektTypCtrl', ($scope, ObjectType, scrollItems, data) ->
    $scope.objectTypes = [
      id:'belysning'
      name:'Belysningsstolpe'
     ,
      id:'kabelskap'
      name:'Kabelskåp'
     ,
      id:'natstationer'
      name:'Nätstation']
      
    $scope.setType = (type) ->
      scrollItems.setBaseItems data[type.id]
      scrollItems.filter.text = ''
      
      if scrollItems.geoSort
        scrollItems.toggleGeoSort((sorted)->
          $scope.$apply ->
            scrollItems.setBaseItems sorted
        ,true)
      
      $scope.objTab.active = true
      ObjectType.selected = type.id
