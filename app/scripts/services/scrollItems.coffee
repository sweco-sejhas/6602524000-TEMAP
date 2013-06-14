'use strict';

angular.module('TEMAPApp')
  .factory 'scrollItems', () ->
    items = []
    numberItems = 50
    start = 0
    end = numberItems
    
    baseItems = null
    
    merge = (prop, left, right) ->
      result = []
      
      while left.length>0 && right.length>0
        if left[0][prop] <= right[0][prop]
          result.push left.shift()
        else
          result.push right.shift()

      while left.length > 0
        result.push left.shift()
      
      while right.length > 0
        result.push right.shift()
        
      result
    
    mergeSort = (arr, prop, cb) ->
      if arr.length < 2
        cb arr
        return
      
      cbcount = 0
      
      middle = Math.floor (arr.length/2)
      left = arr.slice 0, middle
      right = arr.slice middle, arr.length
      
      sortedLeft = null
      sortedRight = null
      
      leftCb = (result) ->
        sortedLeft = result
        if sortedRight != null
          cb(merge prop, sortedLeft, sortedRight)
        
      rightCb = (result) ->
        sortedRight = result
        if sortedLeft != null
          cb(merge prop, sortedLeft, sortedRight)
      
      setTimeout ->
        mergeSort left, prop, leftCb
        mergeSort right, prop, rightCb
      ,0
      
    {
      positionUnavailable:true
      totalSize:0
      currentItems:[]
      bottomPadSize:0
      topPadSize:0
      offset:0
      geoSort:false
      
      getBaseItems:->
        baseItems
      
      executeNameSort:(cb)->
        sorted = baseItems[..]
        mergeSort sorted,'n',cb
      
      executeGeoSort:(cb)->
        sorted = baseItems[..]
        mergeSort sorted,'dist',cb
      
      estimateDistance:->
        for item in baseItems
          item.dist = (Math.pow (item.la - this.pos.latitude), 2) + (Math.pow (item.lo - this.pos.longitude), 2)
      
      toggleGeoSort: (cb, state = !this.geoSort) ->
        this.geoSort = state
        if this.geoSort
          this.estimateDistance()
          this.executeGeoSort(cb)
        else
          this.executeNameSort(cb)
        
      setLocation: (pos) ->
        this.positionUnavailable = false
        this.pos = pos
        
      setItems: (arr)->
        items = arr
        end = numberItems
        this.currentItems = items[0..end]
        $(window).scrollTop(0)
        
      setBaseItems: (arr)->
        baseItems = arr
        this.setItems baseItems
        
      loadMore: (ev) ->
        this.currentItems = items[0..end+=numberItems]
    }
