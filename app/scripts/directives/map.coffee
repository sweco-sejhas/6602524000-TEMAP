'use strict';

angular.module('TEMAPApp')
  .directive('map', ($compile) ->
    template: '<div></div>'
    replace:true
    restrict: 'E'
    scope:
      updateSize:'='
      markers:'='
      highlightMarker:'='
    link: (scope, element, attrs) ->
      window.L_DISABLE_3D = true
      platform = 'other'
      if navigator.userAgent.match /Android/i
        platform = 'android'
      else if navigator.userAgent.match /iPhone|iPad|iPod/i
        platform = 'ios'
      else if navigator.userAgent.match /Windows Phone/
        platform = 'wp'

      scope.platform = platform
        
      map = new L.Map element[0],
        fadeAnimation:platform != 'wp' && platform != 'android'
        zoomAnimation:platform != 'wp' && platform != 'android'
        markerZoomAnimation:platform != 'wp' && platform != 'android'
        touchZoom:platform != 'wp' && platform != 'android'

      map.setView [55.37246, 13.15874],16
      
      tiles = new L.tileLayer 'http://{s}.tile.osm.org/{z}/{x}/{y}.png',
        attribution:'&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors'
      
      tiles.addTo map
      
      group = new L.layerGroup()
      group.addTo map
      
      marker = null
      
      scope.$watch 'updateSize', (val)->
        if val
          map.invalidateSize false
          scope.updateSize = false
      
      constructHref = (lat, lon)->
        switch scope.platform
          when 'ios' then ('http://maps.apple.com/?daddr=' + lat + ',' + lon)
          when 'wp' then ('ms-drive-to:?destination.latitude=' + lat + '&destination.longitude=' + lon)
          else ('http://maps.google.com/?daddr=' + lat + ',' + lon)
          
          
      constructPopup = (item)->
        item.href = constructHref item.la, item.lo
        markerScope = scope.$new()
        markerScope.data = item
        el = $compile('<popup></popup>')(markerScope)
        el[0]
        

      scope.$watch 'markers', (val)->
        group.clearLayers()
        
        for item in val
          itemMarker = new L.marker [item.la, item.lo], icon:new L.Icon 
            iconUrl:'styles/img/bally.png'
            iconSize:[32, 32]
            #href:constructHref item.la, item.lo
          itemMarker.bindPopup(constructPopup item)
          group.addLayer itemMarker
        
        
      scope.$watch 'highlightMarker', (val)->
        if marker?
          map.removeLayer marker
          
        if val
          marker = new L.marker [val.la, val.lo], 
            icon:new L.Icon 
              iconUrl:'styles/img/power.png'
              iconSize:[32, 37]
            zIndexOffset:1000
          marker.bindPopup(constructPopup val)
          marker.addTo map
          map.setView new L.LatLng(val.la, val.lo), 18, true
  )
