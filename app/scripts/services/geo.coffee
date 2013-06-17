'use strict';

angular.module('TEMAPApp')
  .factory 'geo', ($rootScope) ->

    iOS =  if navigator.userAgent.match(/(iPad|iPhone|iPod)/g) then true else false

    locationError = () ->
      $rootScope.$broadcast 'geo::locationUnavailable'
      
    locationUpdate = (pos) ->
      $rootScope.$broadcast 'geo::locationUpdate', pos
    
    ###
      iOS breaks when using watchPosition, so check for ipad/iphone/ipod and use setInterval instead
    ###
    if iOS  
      intervalId = setInterval ->
        navigator.geolocation.getCurrentPosition locationUpdate, locationError,
          enableHighAccuracy:true
          timeout:60000
          maximumAge:600000
      ,5000
    else
      navigator.geolocation.watchPosition locationUpdate,locationError,
        enableHighAccuracy:true
        timeout:60000
        maximumAge:600000
