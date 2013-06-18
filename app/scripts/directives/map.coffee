'use strict';

angular.module('TEMAPApp')
  .directive('map', () ->
    template: '<div></div>'
    replace:true
    restrict: 'E'
    scope:
      updateSize:'='
      markers:'='
      highlightMarker:'='
    link: (scope, element, attrs) ->
      map = new L.Map element[0]
      
      map.setView [55.37246, 13.15874],16
      
      tiles = new L.tileLayer 'http://{s}.tile.osm.org/{z}/{x}/{y}.png',
        attribution:'&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors'
      
      tiles.addTo map
      
      group = new L.layerGroup()
      group.addTo map
      
      marker = null
      
      highlightIcon = new L.icon 
        iconUrl:'styles/img/power.png'
        iconSize:[32, 37]
      
      markerIcon = new L.icon 
        iconUrl:'styles/img/bally.png'
        iconSize:[32, 32]
      
      scope.$watch 'updateSize', (val)->
        if val
          map.invalidateSize false
          scope.updateSize = false
          
      scope.$watch 'markers', (val)->
        group.clearLayers()
        
        for item in val
          itemMarker = new L.marker [item.la, item.lo], icon:markerIcon
          group.addLayer itemMarker
        
        
      scope.$watch 'highlightMarker', (val)->
        if marker?
          map.removeLayer marker
          
        if val
          marker = new L.marker [val.la, val.lo], 
            icon:highlightIcon
            zIndexOffset:1000
          marker.addTo map
          map.setView new L.LatLng(val.la, val.lo), 18, true
  )
