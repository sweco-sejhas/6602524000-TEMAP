// Generated by CoffeeScript 1.6.1
(function() {
  'use strict';
  angular.module('TEMAPApp').directive('map', function($compile) {
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
        var constructHref, constructPopup, group, map, marker, platform, tiles;
        window.L_DISABLE_3D = true;
        platform = 'other';
        if (navigator.userAgent.match(/Android/i)) {
          platform = 'android';
        } else if (navigator.userAgent.match(/iPhone|iPad|iPod/i)) {
          platform = 'ios';
        } else if (navigator.userAgent.match(/Windows Phone/)) {
          platform = 'wp';
        }
        scope.platform = platform;
        map = new L.Map(element[0], {
          fadeAnimation: platform !== 'wp' && platform !== 'android',
          zoomAnimation: platform !== 'wp' && platform !== 'android',
          markerZoomAnimation: platform !== 'wp' && platform !== 'android',
          touchZoom: platform !== 'wp' && platform !== 'android'
        });
        map.setView([55.37246, 13.15874], 16);
        tiles = new L.tileLayer('http://{s}.tile.osm.org/{z}/{x}/{y}.png', {
          attribution: '&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors'
        });
        tiles.addTo(map);
        group = new L.layerGroup();
        group.addTo(map);
        marker = null;
        scope.$watch('updateSize', function(val) {
          if (val) {
            map.invalidateSize(false);
            return scope.updateSize = false;
          }
        });
        constructHref = function(lat, lon) {
          switch (scope.platform) {
            case 'ios':
              return 'http://maps.apple.com/?daddr=' + lat + ',' + lon;
            case 'wp':
              return 'ms-drive-to:?destination.latitude=' + lat + '&destination.longitude=' + lon;
            default:
              return 'http://maps.google.com/?daddr=' + lat + ',' + lon;
          }
        };
        constructPopup = function(item) {
          var el, markerScope;
          item.href = constructHref(item.la, item.lo);
          markerScope = scope.$new();
          markerScope.data = item;
          el = $compile('<popup></popup>')(markerScope);
          return el[0];
        };
        scope.$watch('markers', function(val) {
          var item, itemMarker, _i, _len, _results;
          group.clearLayers();
          _results = [];
          for (_i = 0, _len = val.length; _i < _len; _i++) {
            item = val[_i];
            itemMarker = new L.marker([item.la, item.lo], {
              icon: new L.Icon({
                iconUrl: 'styles/img/bally.png',
                iconSize: [32, 32]
              })
            });
            itemMarker.bindPopup(constructPopup(item));
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
              icon: new L.Icon({
                iconUrl: 'styles/img/power.png',
                iconSize: [32, 37]
              }),
              zIndexOffset: 1000
            });
            marker.bindPopup(constructPopup(val));
            marker.addTo(map);
            return map.setView(new L.LatLng(val.la, val.lo), 18, true);
          }
        });
      }
    };
  });

}).call(this);
