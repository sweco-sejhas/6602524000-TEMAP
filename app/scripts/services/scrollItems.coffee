'use strict';

angular.module('TEMAPApp')
  .factory 'scrollItems', (data) ->
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
      
      getItems:->
        items
      
      estimateDistance:->
        for item in baseItems
          item.dist = (Math.pow (item.la - this.pos.latitude), 2) + (Math.pow (item.lo - this.pos.longitude), 2)
      
      toggleGeoSort: (cb, state = !this.geoSort) ->
        this.geoSort = state
          
      setLocation: (pos) ->
        this.positionUnavailable = false
        this.pos = pos
        if baseItems?
          this.estimateDistance()
        
      setItems: (arr)->
        items = arr
        if this.geoSort
          currItems = data.pickNClosest numberItems, items
          this.currentItems = currItems
        else
          end = numberItems
          this.currentItems = items[0..end]
          
        $(window).scrollTop(0)
        return
        
      setBaseItems: (arr)->
        baseItems = arr
        if this.pos?
          this.estimateDistance()
          
        this.setItems baseItems[...]
        
      loadMore: (ev) ->
        if this.geoSort
          Array::push.apply this.currentItems, data.pickNClosest numberItems, items
        else
          this.currentItems = items[0..end+=numberItems]
    }
