'use strict'

angular.module('TEMAPApp')
  .controller 'ObjektTypCtrl', ($scope, $timeout, ObjectType, scrollItems, data) ->
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
      data.setSelectedType type.id
      scrollItems.setBaseItems data[type.id]
      scrollItems.filter.text = ''
      
      if scrollItems.geoSort
        scrollItems.toggleGeoSort((sorted)->
          $scope.$apply ->
            scrollItems.setBaseItems sorted
        ,true)
      
      ObjectType.selected = type.id
      $scope.objTab.disabled = false
      
      $timeout ->
        $scope.objTab.active = true
