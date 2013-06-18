// Generated by CoffeeScript 1.6.1
(function() {
  'use strict';
  angular.module('TEMAPApp').controller('ObjektCtrl', function($scope, $timeout, ObjectType, data, db, scrollItems, geo) {
    $scope.ObjectType = ObjectType;
    $scope.scrollItems = scrollItems;
    scrollItems.filter = {
      text: ''
    };
    $scope.$on('data::dataUpdated', function(scope) {
      return $scope.$apply();
    });
    $scope.$on('geo::locationUpdate', function(scope, ev) {
      return $scope.$apply(function() {
        return scrollItems.setLocation(ev.coords);
      });
    });
    $scope.selectItem = function(item) {
      $scope.mapTab.disabled = false;
      return data.setSelectedItem(item, function() {
        return $timeout(function() {
          $scope.mapTab.active = true;
          return $timeout(function() {
            return $scope.mapTab.updateSize = true;
          });
        });
      });
    };
    $scope.applyTextFilter = function() {
      var base, item, re, result, _i, _len;
      base = scrollItems.getBaseItems().slice(0);
      result = [];
      re = new RegExp($scope.scrollItems.filter.text, 'i');
      for (_i = 0, _len = base.length; _i < _len; _i++) {
        item = base[_i];
        if (item.n.match(re)) {
          result.push(item);
        }
      }
      return scrollItems.setItems(result);
    };
    return $scope.toggleGeoSort = function() {
      return scrollItems.toggleGeoSort(function(sorted) {
        return $scope.$apply(function() {
          scrollItems.setBaseItems(sorted);
          return $scope.applyTextFilter();
        });
      });
    };
  });

}).call(this);
