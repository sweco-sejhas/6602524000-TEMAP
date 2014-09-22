'use strict';

angular.module('TEMAPApp')
  .factory 'loadMessage', () ->

    queue = []
    
    exists = (msg) ->
      found = null
      for item in queue
        if item.msg == msg
          found = item
          break
          
      found
    
    {
      add: (msg) ->
        item = exists msg
        if !item?
          queue.push 
            msg:msg
            count:1
        else
          item.count++
        
      remove: (msg) ->
        item = exists msg
        if item?
          if item.count > 1
            item.count--
          else
            queue.splice(index, 1) for index, value of queue when value.msg in [msg]
          
            
        
      getCurrent: ->
        if queue.length > 0
          queue[0].msg + '...'
        else
          ''
    }
