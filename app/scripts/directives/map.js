// Generated by CoffeeScript 1.6.1
(function() {
  'use strict';
  angular.module('TEMAPApp').directive('map', function() {
    return {
      template: '<div></div>',
      replace: true,
      restrict: 'E',
      scope: {
        updateSize: '=',
        markers: '=',
        highlightMarker: '='
      },
      link: function(scope, element, attrs) {
        var group, highlightIcon, map, marker, markerIcon, tiles;
        map = new L.Map(element[0]);
        map.setView([55.37246, 13.15874], 16);
        tiles = new L.tileLayer('http://{s}.tile.osm.org/{z}/{x}/{y}.png', {
          attribution: '&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors'
        });
        tiles.addTo(map);
        group = new L.layerGroup();
        group.addTo(map);
        marker = null;
        highlightIcon = new L.icon({
          iconUrl: 'styles/img/power.png',
          iconSize: [32, 37]
        });
        markerIcon = new L.icon({
          iconUrl: 'styles/img/bally.png',
          iconSize: [32, 32]
        });
        scope.$watch('updateSize', function(val) {
          if (val) {
            map.invalidateSize(false);
            return scope.updateSize = false;
          }
        });
        scope.$watch('markers', function(val) {
          var item, itemMarker, _i, _len, _results;
          group.clearLayers();
          _results = [];
          for (_i = 0, _len = val.length; _i < _len; _i++) {
            item = val[_i];
            itemMarker = new L.marker([item.la, item.lo], {
              icon: markerIcon
            });
            _results.push(group.addLayer(itemMarker));
          }
          return _results;
        });
        return scope.$watch('highlightMarker', function(val) {
          if (marker != null) {
            map.removeLayer(marker);
          }
          if (val) {
            marker = new L.marker([val.la, val.lo], {
              icon: highlightIcon,
              zIndexOffset: 1000
            });
            marker.addTo(map);
            return map.setView(new L.LatLng(val.la, val.lo), 18, true);
          }
        });
      }
    };
  });

}).call(this);