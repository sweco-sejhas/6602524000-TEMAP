'use strict'

angular.module('TEMAPApp')
  .controller 'ObjektCtrl', ($scope, $timeout, ObjectType, data, db, scrollItems, geo) ->
    $scope.ObjectType = ObjectType
    $scope.scrollItems = scrollItems
    
    scrollItems.filter = text:''
    
    $scope.$on 'data::dataUpdated', (scope)->
      $scope.$apply()
      
    $scope.$on 'geo::locationUpdate', (scope, ev)->
      $scope.$apply(->
        scrollItems.setLocation ev.coords
      )
      
    
    $scope.selectItem = (item) ->
      $scope.mapTab.disabled = false
      
      data.setSelectedItem item, ->
        $timeout ->
          $scope.mapTab.active = true
          $timeout ->
            $scope.mapTab.updateSize = true
    
    $scope.applyTextFilter = ->
      base = scrollItems.getBaseItems()[..]
      result = []
      re = new RegExp $scope.scrollItems.filter.text, 'i'
      
      for item in base
        if item.n.match re
          result.push item
          
      scrollItems.setItems result
      
      
    $scope.toggleGeoSort = ->
      scrollItems.toggleGeoSort((sorted)->
        $scope.$apply ->
          scrollItems.setBaseItems sorted
          $scope.applyTextFilter()
      )
