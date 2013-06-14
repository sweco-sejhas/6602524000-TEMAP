'use strict';

angular.module('TEMAPApp')
  .directive('onFinishRender', ($timeout) ->
    restrict: 'A'
    link: (scope, element, attr) ->
      if scope.$last == true
        $timeout ->
          scope.$eval(attr.onFinishRender)
)
