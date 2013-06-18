// Generated by CoffeeScript 1.6.1
(function() {
  'use strict';
  angular.module('TEMAPApp').controller('DataUpdateCtrl', function($scope, data, db, loadMessage) {
    $scope.updating = true;
    $scope.data = data;
    $scope.loadMessage = loadMessage;
    $scope.$on('data::dataUpdated', function(ev) {
      return $scope.$apply(function() {
        return $scope.updating = false;
      });
    });
    return data.update();
  });

}).call(this);
