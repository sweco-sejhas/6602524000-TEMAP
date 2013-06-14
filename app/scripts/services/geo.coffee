'use strict';

angular.module('TEMAPApp')
  .factory 'geo', ($rootScope) ->

    navigator.geolocation.getCurrentPosition
    
    locationError = () ->
      $rootScope.$broadcast 'geo::locationUnavailable'
      
    locationUpdate = (pos) ->
      $rootScope.$broadcast 'geo::locationUpdate', pos

    navigator.geolocation.watchPosition locationUpdate,locationError,
      enableHighAccuracy:true
      timeout:60000
      maximumAge:600000
