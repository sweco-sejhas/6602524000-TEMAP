'use strict';

angular.module('TEMAPApp')
  .factory 'data', ($rootScope, $http, db, mergeSort, loadMessage) ->
    
    selectedType = null
    closestItems = []
    selectedItem = null
    
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
      loadMessage.remove 'Kontrollerar version av databas'
      loadMessage.add 'Uppdaterar databasen'
      $http.get('data/' + name + '.json' + noCache()).then (res)->
        db.initDb ->        
          db.persist name,version, res.data, ->
            loadMessage.remove 'Uppdaterar databasen'
            fetch name
            
            
    fetch = (name) ->
      loadMessage.remove 'Kontrollerar version av databas'
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
              loadMessage.add 'Kontrollerar version av databas'
              db.needsUpdate k,v,update,fetch
              
            return 1
            
      setSelectedType: (t) ->
        selectedType = t
            
      setSelectedItem: (item, cb) ->
        selectedItem = item
        this.setClosestItems item, cb
        
      getSelectedItem: ->
        selectedItem
          
      estimateDistance: (items, base)->
        for item in items
          item.dist = (Math.pow (item.la - base.la), 2) + (Math.pow (item.lo - base.lo), 2)
            
      setClosestItems: (item, cb) ->
        candidates = this[selectedType][..]
        this.estimateDistance candidates, item
        mergeSort.sort candidates, 'dist', (sorted)->
          closestItems = sorted[1..101]
          cb()
        
        closestItems = []
        
      getClosestItems: () ->
        closestItems
    }
