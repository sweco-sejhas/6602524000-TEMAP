'use strict';

angular.module('TEMAPApp')
  .directive('popup', () ->
    restrict: 'E'
    replace:true
    template: '<div><h4 class="map-popup">{{data.n}}</h4><a target="_blank" href="{{data.href}}"><img src="styles/img/routes-icon.png"/></a></div>'
)
