'use strict';

angular.module('TEMAPApp')
  .factory 'scrollItems', (mergeSort) ->
    items = []
    numberItems = 50
    start = 0
    end = numberItems
    
    baseItems = null

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
        mergeSort.sort sorted,'n',cb
      
      executeGeoSort:(cb)->
        sorted = baseItems[..]
        mergeSort.sort sorted, 'dist', cb
      
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
