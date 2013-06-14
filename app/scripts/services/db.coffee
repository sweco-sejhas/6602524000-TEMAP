'use strict';

angular.module('TEMAPApp')
  .factory 'db', () ->
   
    timeoutId = null
    idb = null
    
    req = indexedDB.open('TEMAP_DB')
   
    #Get hold of the indexed-db object
    req.onsuccess = (evt)-> 
      idb = req.result
    
    req.onupgradeneeded = (evt) ->
      idb = evt.target.result
      osVersion = idb.createObjectStore 'version', keyPath:'n'
      osBelysning = idb.createObjectStore 'belysning', keyPath:'n' 
      osKabelskap = idb.createObjectStore 'kabelskap', keyPath:'n' 
      osNatstationer = idb.createObjectStore 'natstationer', keyPath:'n'  
    
    req.onerror = (evt) ->
      console.log 'IndexedDB error: ' + evt.target.errorCode
    
    updateVersion = (name, version, cb) ->
      transaction = idb.transaction ['version'], 'readwrite'
      store = transaction.objectStore('version')
        
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
    
      clear: (name, cb) ->
        transaction = idb.transaction [name], 'readwrite'
        transaction.oncomplete = cb
          
        transaction.onerror = (ev) ->
          console.log 'transaction-error'
        
        store = transaction.objectStore name
        req = store.clear()
        
        req.onsuccess = (evt) ->
        req.onerror = (evt) ->
        
      needsUpdate: (name, version, update, noUpdate) ->
        transaction = idb.transaction ['version'], 'readwrite'
        store = transaction.objectStore('version')
        
        req = store.get(name)
        req.onerror = (evt) ->
          
        req.onsuccess = (evt) ->
          #Compare versions
          if !evt.target.result? || evt.target.result.version != version
            update(name, version)
          else
            noUpdate(name)
      
      persist: (name, version, data, cb) ->
        this.clear name, ->
          transaction = idb.transaction [name], 'readwrite'
          transaction.oncomplete = ()->
            updateVersion(name, version, cb)
            
          transaction.onerror = (ev) ->
            #TODO
          
          store = transaction.objectStore name
          for item in data
            req = store.add item
            req.onsuccess = (evt) ->
            req.onerror = (ev) ->
            
          return

      getAsArray: (name, cb) ->
        all = []
        transaction = idb.transaction [name], 'readwrite'
        transaction.oncomplete = ()->
          cb(all)
        
        store = transaction.objectStore name
        store.openCursor().onsuccess = (evt) ->
          cursor = evt.target.result
          if cursor?
            all.push cursor.value
            cursor.continue()
    }
