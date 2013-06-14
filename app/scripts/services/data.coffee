'use strict';

angular.module('TEMAPApp')
  .factory 'data', ($rootScope, $http, db) ->
    
    scope = null
    
    expectedcount = 3
    loadcount = 0
    
    noCache = () ->
      '?nocache=' + (new Date()).getTime()
    
    broadcast = (name)->
      loadcount++
      if loadcount == expectedcount
        $rootScope.$broadcast 'data::dataUpdated'
    
    update = (name, version) ->
      $http.get('data/' + name + '.json' + noCache()).then (res)->
        db.initDb ->        
          db.persist name,version, res.data, ->
            fetch name
            
            
    fetch = (name) ->
      db.getAsArray name,(arr)->
        scope[name] = arr
        broadcast name
    
    {     
      update: () ->
        scope = this
        $http.get('data/version.json' + noCache()).then (res)->
          db.initDb ->
            versions = res.data
            for k,v of versions
              db.needsUpdate k,v,update,fetch
              
            return 1
    }
