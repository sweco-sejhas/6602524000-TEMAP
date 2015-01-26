'use strict';

angular.module('TEMAPApp')
  .factory 'db', () ->
   
    timeoutId = null
    idb = null
    
    dbVersion = 2
    
    browserObject = window.overrideIndexedDB || window.indexedDB || window.mozIndexedDB || window.webkitIndexedDB || window.msIndexedDB;
    
    req = browserObject.open('TEMAP_DB',dbVersion)
   
    #Get hold of the indexed-db object
    req.onsuccess = (evt)-> 
      db = req.result
      if db.setVersion?
        if db.version != dbVersion
          versionReq = db.setVersion dbVersion
          versionReq.onsuccess = () ->
            if db.objectStoreNames.contains 'dataVersion'
              db.deleteObjectStore 'dataVersion'
            if db.objectStoreNames.contains 'data'
              db.deleteObjectStore 'data'
            
            osVersion = db.createObjectStore 'dataVersion', keyPath:'n'
            osData = db.createObjectStore 'data', keyPath:'n'
            versionReq.result.oncomplete = () ->
              idb = db
      else
        idb = db
        
    
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
        transaction = idb.transaction ['dataVersion'], 'readwrite'
        store = transaction.objectStore('dataVersion')
        req = store.get(name) 
        
        req.onerror = (evt) ->
          console.log 'IndexedDB error: ' + evt.target.errorCode
          
        req.onsuccess = (evt) ->
          #Compare versions
          if !evt.target.result? || evt.target.result.version != version 
            update name, version
          else 
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
