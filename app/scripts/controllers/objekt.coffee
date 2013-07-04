'use strict'

angular.module('TEMAPApp')
  .controller 'ObjektCtrl', ($scope, $timeout, ObjectType, data, db, scrollItems) ->
    $scope.ObjectType = ObjectType
    $scope.scrollItems = scrollItems
    
    scrollItems.filter = text:''
    
    $scope.$on 'data::dataUpdated', ()->
      $scope.$apply()
      
    $scope.$on 'geo::locationUpdate', (scope, ev)->
      $scope.$apply(->
        scrollItems.setLocation ev.coords
      )
      
    $scope.selectItem = (item) ->
      $scope.mapTab.disabled = false
      data.setSelectedItem item
      $timeout ->
        $scope.mapTab.active = true
        $timeout ->
          $scope.mapTab.updateSize = true
    
    $scope.filterArray = (base) ->
      result = []
      
      re = new RegExp $scope.scrollItems.filter.text, 'i'
      
      for item in base
        if item.n.match re
          result.push item
          
      result
    
    $scope.applyTextFilter = ->
      base = scrollItems.getBaseItems()[..]    
      scrollItems.setItems $scope.filterArray base
      
    $scope.toggleGeoSort = ->
      if scrollItems.toggleGeoSort()
        items = scrollItems.getItems()
      else
        items = scrollItems.getBaseItems()[...]
        
      scrollItems.setItems $scope.filterArray items
