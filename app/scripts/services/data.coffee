'use strict';

angular.module('TEMAPApp')
  .factory 'data', ($rootScope, $http, db, loadMessage) ->
    
    selectedType = null
    closestItems = []
    selectedItem = null
    
    scope = null
    
    expectedcount = 3
    loadcount = 0
    
    comp = (x,y) ->
      if x.dist < y.dist
        -1
      else if x.dist > y.dist
        1
      else
        0
    
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
            
      setSelectedItem: (item) ->
        selectedItem = item
        this.setClosestItems item
        
      getDataArray: ->
        return this[selectedType]
        
      getSelectedItem: ->
        selectedItem
          
      estimateDistance: (items, base)->
        for item in items
          item.dist = (Math.pow (item.la - base.la), 2) + (Math.pow (item.lo - base.lo), 2)
            
      setClosestItems: (item) ->
        candidates = this[selectedType][..]
        this.estimateDistance candidates, item
        closestItems = this.pickNClosest 100, candidates
        
      pickNClosest: (nbr, items) ->
        currItems = []
        count = 0
        for i in [items.length-1..0]
            item = items[i]
            if count < nbr
              count++
              Heap.insort currItems, item,null,null,comp
              items.splice i,1
              
            else if item.dist < currItems[currItems.length-1].dist
              Heap.insort currItems, item,null,null,comp
              currItems.pop()
              items.splice i,1
              
        currItems
        
      getClosestItems: () ->
        closestItems
    }
