// Generated by CoffeeScript 1.6.1
(function() {
  'use strict';
  angular.module('TEMAPApp').directive('onFinishRender', function($timeout) {
    return {
      restrict: 'A',
      link: function(scope, element, attr) {
        if (scope.$last === true) {
          return $timeout(function() {
            return scope.$eval(attr.onFinishRender);
          });
        }
      }
    };
  });

}).call(this);