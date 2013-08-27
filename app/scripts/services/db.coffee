'use strict';

angular.module('TEMAPApp')
  .factory 'db', () ->
   
    timeoutId = null
    idb = null
    
    req = indexedDB.open('TEMAP_DB',2)
   
    #Get hold of the indexed-db object
    req.onsuccess = (evt)-> 
      idb = req.result
    
    req.onupgradeneeded = (evt) ->
      db = evt.target.result
      osVersion = db.createObjectStore 'dataVersion', keyPath:'n'
      osData = db.createObjectStore 'data', keyPath:'n'
    
    req.onerror = (evt) ->
      console.log 'IndexedDB error: ' + evt.target.errorCode
    
    updateVersion = (name, version, cb) ->
      transaction = idb.transaction ['dataVersion'], 'readwrite'
      store = transaction.objectStore('dataVersion')
        
      req = store.put 
        n:name
        version:version
        
      req.onerror = (evt) ->
      req.onsuccess = (evt) ->
        cb()
        
    {
      initDb: (cb) ->
        scope = this
        if idb == null
          timeoutId = setTimeout ->
            scope.initDb(cb)
          ,10
        else
          cb()
       
      needsUpdate: (name, version, update, noUpdate) ->
        
        console.log '0 needsUpdate::' + name 
        transaction = idb.transaction ['dataVersion'], 'readwrite'
        console.log '1 needsUpdate::' + name 
        store = transaction.objectStore('dataVersion')
        console.log '2 needsUpdate::' + name 
        req = store.get(name)
        console.log '3 needsUpdate::' + name 
        
        req.onerror = (evt) ->
          console.log '4 needsUpdate::' + name 
          console.log 'IndexedDB error: ' + evt.target.errorCode
          
        req.onsuccess = (evt) ->
          console.log '5 needsUpdate::' + name 
          #Compare versions
          if !evt.target.result? || evt.target.result.version != version
            console.log '6 needsUpdate::' + name 
            update name, version
          else
            console.log '7 needsUpdate::' + name 
            noUpdate name
      
      persist: (name, version, data, cb) ->
        transaction = idb.transaction ['data'], 'readwrite'
        transaction.oncomplete = ()->
          #TODO?
          
        transaction.onerror = (ev) ->
          #TODO
        
        store = transaction.objectStore 'data'
        
        req = store.put 
         n:name
         data:data
        
        req.onerror = (evt) ->
        req.onsuccess = (evt) ->
          updateVersion(name, version, cb)
        
      getAsArray: (name, cb) ->
        transaction = idb.transaction ['data'], 'readwrite'
        transaction.oncomplete = ()->
          #TODO?
        
        store = transaction.objectStore 'data'
            
        req = store.get(name)
        req.onerror = (evt) ->
          
        req.onsuccess = (evt) ->
          cb evt.target.result.data
    }
